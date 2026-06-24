# Architecture — mvpid

## Stack
- **Frontend:** Next.js 14 (App Router) on Vercel
- **Database + Auth:** Supabase (Postgres, RLS, Auth — auth added Sprint 3)
- **Email (Sprint 4):** Resend
- **AI (Sprint 5):** OpenAI via server-side API route only

## Now vs Later (feature terms)
**Now:** idea landing page, signup form, core action form, admin demand view
**Later:** auth + isolation, email alerts, shareable links, AI demand summary

## Key User Action — Step by Step
1. Visitor opens `/` — Next.js fetches the active idea row from Supabase
2. Visitor submits signup form — server action inserts row into `signups`, writes to `activities`
3. Visitor submits core action form — server action inserts row into `core_actions`, updates `ideas.demand_score`, writes to `activities`
4. Landing page re-renders signup count + action count from live DB query
5. Builder opens `/admin` — server fetches all signups + core actions + demand score for the idea

## Layer Plan
1. **Data first** — tables, seed rows, open RLS policies (Sprint 1)
2. **App logic** — forms, server actions, CRUD, demand score rule (Sprints 1–2)
3. **Security** — auth, owner-scoped RLS, protected /admin (Sprint 3)
4. **Smart features** — AI summary, confidence scores, scalability flag (Sprint 5)

## Core Runs Without AI
Demand score is a deterministic rule (`signups × 1 + core_actions × 3`). AI adds a readable summary on top but is never required for the app to function.
