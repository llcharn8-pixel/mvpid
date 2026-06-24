# Security — mvpid

## Secret Handling
- `SUPABASE_SERVICE_ROLE_KEY` and `OPENAI_API_KEY` live in Vercel environment variables only
- Never referenced in client components or exposed via public API routes
- All AI and privileged DB calls go through Next.js server actions or `/api` routes

## Permission Model (end state, reached at Sprint 3)
- Anonymous visitors: read the active idea, submit signups and core actions only
- Authenticated builder: full CRUD on their own ideas, signups, core_actions (`user_id = auth.uid()`)
- /admin route: protected by Supabase session check; redirects to /login if unauthenticated
- No other roles in v1

## v1 Interim (Sprints 1–2)
- Open RLS policies (`using (true)`) — acceptable for demo with no real PII yet
- Sprint 3 replaces all open policies with owner-scoped policies before any real user data is collected

## Approved-Tools Rule
- Agent may only call the named tools listed in AGENTIC_LAYER.md
- `run_any`, `exec`, `send_any` are never permitted
- Every agent action is preceded by a risk-level check; high/critical actions require an explicit builder confirmation step

## Audit Principle
- Every meaningful write (insert, update, delete, email send) appends a row to `audit_logs`
- `audit_logs` has no delete policy — records are permanent
- Audit rows include full payload snapshot for forensic replay
