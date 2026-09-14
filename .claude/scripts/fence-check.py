#!/usr/bin/env python3
"""Decide whether one tool call crosses the irreversible fence.

Reads a PreToolUse payload on stdin. Prints one line — the reason the call is
blocked — or nothing when the call is fine. It never blocks by itself; the hook
that calls it owns the blocking.

`.claude/rules/crm-usage.md` already sorts outbound actions by reversibility:

    draft  -> allowed (nothing leaves until a person sends it)
    send   -> blocked
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
"""
import json
import os
import sys

# Tools that match a blocked pattern but are genuinely safe. Exact tool names.
ALWAYS_ALLOW = {
    # e.g. "mcp__yourcrm__create_draft",
}

# Tools to block outright, whatever their name suggests. Exact tool names.
NEVER_UNATTENDED = {
    # e.g. "mcp__yourbilling__charge_customer",
}

# Name fragments that mean the effect leaves your machine or destroys a record.
# `draft` is checked first, because "send_draft" is a draft, not a send.
IRREVERSIBLE_FRAGMENTS = (
    ("send", "sends a message — external the moment it leaves"),
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


def main() -> int:
    try:
        event = json.load(sys.stdin)
    except Exception:
        return 0  # an unreadable payload is not a finding

    tool = event.get("tool_name") or ""
    args = event.get("tool_input") or {}
    name = tool.lower()

    if not tool.startswith("mcp__"):
        return 0  # local tools are covered by the permissions deny list
    if tool in ALWAYS_ALLOW:
        return 0

    if tool in NEVER_UNATTENDED:
        print("This tool is on the never-unattended list. Prepare it and hand it over.")
        return 0

    # A draft is the safe half of outbound, so it wins over a "send" in the name.
    if any(frag in name for frag in SAFE_FRAGMENTS):
        return 0

    for fragment, what in IRREVERSIBLE_FRAGMENTS:
        if fragment not in name:
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
