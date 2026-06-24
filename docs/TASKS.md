# Tasks — mvpid

## Gantt (sprint → feature)
```
Sprint 1 | DB schema + seed | Landing page | Signup form | Core action form | Live counts
Sprint 2 | Admin dashboard | Demand score | Sellability flag
Sprint 3 | Auth + RLS lock-down                                          ← security gate
Sprint 4 | Email notifications | Shareable link | Referral source
Sprint 5 | AI demand summary | Confidence score | Builder review UI
```

---

## Sprint 1 — DB + Core Engine
**Goal:** Idea renders for anonymous visitors; signup and core action persist to DB end-to-end.

- [ ] Run migration SQL (all tables + seed rows)
- [ ] `/` — fetch active idea from DB, render title + pitch + CTA; no login required
- [ ] Signup form: name, email, intent fields → `signups` insert → success message
- [ ] Core action form: action-specific fields → `core_actions` insert → `ideas.demand_score` recalc
- [ ] Display live signup_count + core_action_count on landing page
- [ ] Write activity row on each signup and action
- [ ] Empty state: "Be the first to sign up" when no signups exist
- [ ] Error state: form shows inline error if DB insert fails
- [ ] Loading state: button disabled + spinner during submit

**DoD:** Stranger submits form → row in DB → count updates on page. No login wall. Seeded rows visible.

> ✅ **v1 functional milestone** — success scenario is fully usable after this sprint.

---

## Sprint 2 — Admin Dashboard
**Goal:** Builder can see all signups, actions, and demand score without auth.

- [ ] `/admin` — table of all signups (name, email, intent, timestamp)
- [ ] `/admin` — table of all core action completions (action_label, action_data, timestamp)
- [ ] Demand score card: formula `signups×1 + actions×3`, displayed prominently
- [ ] Sellability flag: rule-based label next to demand score
- [ ] Empty states for zero signups and zero actions
- [ ] Seed additional demo rows to populate the dashboard

**DoD:** /admin loads with real + seeded data, score is accurate, no broken UI.

---

## Sprint 3 — Lock It Down *(security gate — run before real users)*
**Goal:** Builder's data is isolated; /admin is private.

- [ ] Enable Supabase Auth (email magic link)
- [ ] Add `user_id` FK logic; backfill demo rows with a demo owner UUID
- [ ] Replace all `v1` open RLS policies with `auth.uid() = user_id` owner policies
- [ ] Protect `/admin` with session check → redirect to `/login` if unauthenticated
- [ ] Public `/` still works for anonymous visitors
- [ ] Test: logged-out user cannot read another builder's signups via Supabase client

**DoD:** Unauthenticated /admin → redirect to login. Authenticated builder sees only their data.

---

## Sprint 4 — Notifications + Sharing
**Goal:** Builder gets alerted and can share the idea page.

- [ ] Resend integration: email builder on new signup and on new core action
- [ ] Generate unique shareable URL per idea (slug or UUID in path)
- [ ] Add optional referral_source field to signup form
- [ ] Log all email sends to audit_logs

**DoD:** Builder receives email within 60s of a new signup. Shareable link opens the right idea.

---

## Sprint 5 — Intelligence Layer
**Goal:** AI surfaces demand patterns so the builder can make a faster go/no-go call.

- [ ] Server action calls OpenAI to generate `ai_summary` from signup intents
- [ ] Store ai_summary + ai_summary_source + ai_summary_confidence + ai_summary_review_status
- [ ] /admin shows AI summary card with 'Approve' / 'Reject' buttons
- [ ] Approved summaries display on /admin; rejected ones are hidden
- [ ] Scalability flag generated from action pattern data (rule + AI hybrid)
- [ ] All AI calls logged to audit_logs

**DoD:** AI summary appears in /admin, builder can approve/reject, status persists to DB.
