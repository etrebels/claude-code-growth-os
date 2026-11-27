#!/usr/bin/env python3
"""Decide whether one tool call crosses the irreversible fence.

Reads a PreToolUse payload on stdin. Prints one line — the reason the call is
blocked — or nothing when the call is fine. It never blocks by itself; the hook
that calls it owns the blocking.

`.claude/rules/crm-usage.md` already sorts outbound actions by reversibility:

    draft  -> allowed (nothing leaves until a person sends it)
    send   -> blocked
    share  -> blocked (a link that has been opened cannot be un-opened, and a
                       shared recording hands out words that are not yours)
    delete -> blocked

Until now that was prose an unattended run was asked to honour. This is the
same fence at the tool layer, so it holds when the reasoning does not.

MAKE IT YOURS. The two lists below are the whole configuration:

  ALWAYS_ALLOW  tools that look irreversible by name but are not, plus the one
                agreed destination your briefing posts to.
  NEVER_UNATTENDED  extra tool names to block outright.

Name-matching is the fallback, not the design: a tool called `send_message` is
blocked because of what its name says it does. Add the tools your own stack
exposes rather than trusting the pattern to catch them.

A safe word (draft, read, list, get, search, fetch, preview) lets a call
through only when it is a whole word of the tool's own name, the part after
the last `__`. Hidden inside another word, or in the connector's name, it does
not count:

    mcp__mail__send_draft            allowed  (draft is a whole word)
    mcp__mail__send_thread_reply     blocked  (thread is not read)
    mcp__mail__delete_thread         blocked
    mcp__crm__delete_target_account  blocked  (target is not get)
    mcp__sheets__delete_spreadsheet  blocked  (spreadsheet is not read)
    mcp__drive__share_spreadsheet    blocked
    mcp__getmail__send_email         blocked  (the connector's name does not count)
    mcp__slack__chat_postMessage     blocked  (camelCase is read as post_message)
"""
import json
import os
import re
import sys

# Tools that match a blocked pattern but are genuinely safe. Exact tool names.
ALWAYS_ALLOW = {
    # e.g. "mcp__yourcrm__create_draft",
    # A benign share belongs here too — a single-use scheduling link is
    # reversible and is yours to hand out, unlike a meeting recording.
    # e.g. "mcp__yourscheduler__shares-create_share",
}

# Tools to block outright, whatever their name suggests. Exact tool names.
NEVER_UNATTENDED = {
    # e.g. "mcp__yourbilling__charge_customer",
}

# Name fragments that mean the effect leaves your machine or destroys a record.
# `draft` is checked first, because "send_draft" is a draft, not a send.
IRREVERSIBLE_FRAGMENTS = (
    ("send", "sends a message — external the moment it leaves"),
    ("share", "shares a recording, transcript or record outside the workspace"),
    ("delete", "deletes a record — it destroys the system of record"),
    ("remove", "removes a record"),
    ("archive", "archives a record out of the working set"),
    ("cancel", "cancels something other people are holding"),
    ("invite", "commits you to another person"),
    ("publish", "publishes outward"),
    ("post_message", "posts outward"),
)

SAFE_FRAGMENTS = ("draft", "read", "list", "get", "search", "fetch", "preview")

# The one destination an unattended run may post to, if you have one. Set
# LO_BRIEFING_CHANNEL (or edit this) to your briefing channel's id.
BRIEFING = (os.environ.get("LO_BRIEFING_CHANNEL") or "").lower()


def _snake(text):
    """sendMessage -> send_message, so camelCase names read like the rest."""
    return re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", text).lower()


def _own_words(tool):
    """The words of the tool's own name: the part after the last `__`."""
    return {w for w in re.split(r"[^a-z0-9]+", _snake(tool.split("__")[-1])) if w}


def main() -> int:
    try:
        event = json.load(sys.stdin)
    except Exception:
        return 0  # an unreadable payload is not a finding

    tool = event.get("tool_name") or ""
    args = event.get("tool_input") or {}
    name = tool.lower()
    snake = _snake(tool)  # postMessage -> post_message; only ever adds a match

    if not tool.startswith("mcp__"):
        return 0  # local tools are covered by the permissions deny list
    if tool in ALWAYS_ALLOW:
        return 0

    if tool in NEVER_UNATTENDED:
        print("This tool is on the never-unattended list. Prepare it and hand it over.")
        return 0

    # A draft is the safe half of outbound, so it wins over a "send" in the name.
    # A safe word counts only as a whole word of the tool's own name: matching
    # it anywhere in the name let `delete_thread` through, because `thread`
    # contains `read`.
    if _own_words(tool) & set(SAFE_FRAGMENTS):
        return 0

    for fragment, what in IRREVERSIBLE_FRAGMENTS:
        if fragment not in name and fragment not in snake:
            continue
        # The agreed briefing destination is the one exception to a send.
        if fragment == "send" and BRIEFING:
            dest = str(args.get("channel_id") or args.get("channel") or "").lower()
            if BRIEFING in dest:
                return 0
        print("This %s. An unattended run prepares it; a person sends it." % what)
        return 0

    return 0


if __name__ == "__main__":
    sys.exit(main())
