# Test Plan — mvpid

## Core Success Scenario (manual)
1. Open `/` without logging in → idea title, pitch, and CTA button are visible
2. Submit signup form with name="Test User", email="test@example.com", intent="I want this" → confirmation message appears, signup count increments by 1
3. Submit core action form → success message appears, action count increments by 1
4. Open `/admin` → Test User row appears in signups table; action appears in core actions table; demand score updated (+1 signup, +3 action = 4 new points)
5. Reload `/` → counts reflect the new rows (not just client state)

## Empty State Tests
- Delete all signups rows (or use a fresh idea) → `/` shows "Be the first to sign up"
- Delete all core_actions rows → `/admin` core actions table shows "No actions yet"
- Admin demand score shows 0 with "unscored" flag

## Error State Tests
- Submit signup form with empty email → inline validation error, no DB insert
- Submit signup form with duplicate email for same idea → graceful error message (or allow and log)
- Simulate DB timeout (offline mode) → form shows "Something went wrong, please try again"

## Loading State Tests
- Click signup submit → button shows spinner and is disabled until response returns
- Click core action submit → same spinner behaviour

## Permission Tests (Sprint 3+)
- Open `/admin` without a session → redirected to `/login`
- Authenticated builder cannot read another builder's signups via direct Supabase query
- Anonymous visitor can still submit signup and core action after lock-down

## Demand Score Accuracy
- 3 signups + 2 core actions → demand_score = (3×1)+(2×3) = 9, flag = "Early signal"
- 4 signups + 3 core actions → demand_score = (4×1)+(3×3) = 13, flag = "Signal detected"
