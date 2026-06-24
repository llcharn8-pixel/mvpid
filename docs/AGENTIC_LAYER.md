# Agentic Layer — mvpid

## Risk Levels & Actions

### Low — auto-execute (no approval needed)
- `tag_intent` — extract intent theme from signup.intent text, store to activities
- `score_demand` — recalculate demand_score after each signup or core action
- `draft_summary` — generate ai_summary for an idea, set review_status = 'unreviewed'

### Medium — light approval (builder confirms before write)
- `flag_high_intent_signup` — mark a signup as high-intent and surface in admin
- `update_sellability_flag` — upgrade idea's sellability_flag based on new score

### High — always requires explicit builder approval
- `send_followup_email` — draft + send an email to a specific signup
- `export_signups_csv` — export personally identifiable signup data

### Critical — human-only, no agent execution
- `delete_idea` — permanent removal of an idea and all its signups/actions
- `delete_signup` — removal of a user's personal data (GDPR)

## Named Tools (approved list)
- `supabase_insert` — write a row to any permitted table
- `supabase_update` — update a row the agent owns
- `supabase_select` — read permitted rows
- `openai_complete` — generate text with a fixed system prompt
- `resend_send` — send a transactional email (high risk, approval required)

## Audit Log Fields
`action | entity_type | entity_id | payload (full snapshot) | user_id | created_at`

Every agent write calls `supabase_insert` on `audit_logs` as its final step.

## v1 vs Later
- **v1:** only `score_demand` runs automatically on each form submit
- **Sprint 5:** `draft_summary`, `tag_intent`, `flag_high_intent_signup` added
- **Sprint 4:** `send_followup_email` added with approval gate
