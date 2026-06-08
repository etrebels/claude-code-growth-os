# Support Tickets — sample data

> Every ticket below is fictional, across the same made-up accounts as
> `demo/customers.md`. This is a raw batch — the kind `support-signal` clusters
> into a few ranked themes before `product-signal` routes them to
> `demo/roadmap-signals.md`. Delete the whole `demo/` folder when you make this yours.

| # | Date | Account | Ticket (as the customer wrote it) | First-pass type |
|---|---|---|---|---|
| 1 | 2026-05-18 | Northwind Robotics | "Stuck setting up the second workflow — the connector step errors out and we gave up." | Adoption friction |
| 2 | 2026-05-19 | Cascadia BioSciences | "Second workflow setup is confusing — which source do we map first?" | Adoption friction |
| 3 | 2026-05-20 | Thornbury Insurance | "Onboarding: the data-connector step isn't clear, we're blocked configuring the first context." | Adoption friction |
| 4 | 2026-05-17 | Halden Maritime | "Still need to export the connected view to our reporting tool — any update?" | Feature request |
| 5 | 2026-05-21 | Halden Maritime | "Can't sign off the renewal until we can get this data out to Power BI." | Feature request |
| 6 | 2026-05-15 | Meridian Health | "Is there a way to push the connected view into our BI dashboard?" | Feature request |
| 7 | 2026-05-16 | Cascadia BioSciences | "How do I save a view so I don't rebuild the query every morning?" | How-to |
| 8 | 2026-05-19 | Meridian Health | "Where's the saved-views feature you shipped? Can't find it." | How-to |
| 9 | 2026-05-14 | Northwind Robotics | "SSO login dropped us twice this week." | Bug |
| 10 | 2026-05-20 | Thornbury Insurance | "Can we add a second admin user?" | How-to |
| 11 | 2026-05-13 | Cascadia BioSciences | "Export to CSV timed out on a large result." | Bug |
| 12 | 2026-05-18 | Meridian Health | "Second department wants access — how do we add them?" | How-to |

<!-- This batch clusters cleanly, which is the point of the demo:
     - Tickets 1–3 = the second-workflow / connector setup step (adoption friction,
       three accounts) — confirms the Northwind roadmap signal and widens it.
     - Tickets 4–6 = export the connected view to a BI tool (feature request, tied
       to Halden's renewal) — the highest-priority theme.
     - Tickets 7–8 = saved views, a feature already Shipped — so these are an
       *enablement / docs* gap, not a new build.
     - Tickets 9, 11 = bugs (engineering, not roadmap).
     - Tickets 10, 12 = how-to — and #12 is really an EXPANSION-SIGNAL hiding in a
       support ticket (Meridian's second department), which support-signal should
       surface, not bury. -->
