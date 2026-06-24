# Data Model — mvpid

## ideas
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | owner (set at lock-down sprint) |
| title | text | idea name |
| pitch | text | 1–3 sentence description shown on landing |
| core_action_label | text | CTA button copy e.g. "Start my free trial" |
| demand_score | numeric | rule: signups×1 + core_actions×3 |
| sellability_flag | text | 'unscored' / 'Early signal' / 'Signal detected' |
| scalability_flag | text | 'unscored' / 'Possible' / 'Likely' |
| ai_summary | text | **AI field** |
| ai_summary_source | text | model + prompt version |
| ai_summary_confidence | numeric | 0–1 |
| ai_summary_review_status | text | 'unreviewed' / 'approved' / 'rejected' |
| created_at | timestamptz | |

## signups
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| idea_id | uuid | FK → ideas.id |
| name | text | |
| email | text | |
| intent | text | why they signed up |
| referral_source | text | optional |
| created_at | timestamptz | |

## core_actions
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| idea_id | uuid | FK → ideas.id |
| signup_id | uuid nullable | FK → signups.id |
| action_label | text | copy of the CTA at time of action |
| action_data | jsonb | any extra fields from the action form |
| completed_at | timestamptz | |
| created_at | timestamptz | |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| idea_id | uuid | |
| event_type | text | e.g. 'signup.created', 'core_action.completed' |
| entity_type | text | |
| entity_id | uuid | |
| metadata | jsonb | |
| created_at | timestamptz | |

## audit_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| action | text | verb e.g. 'insert' |
| entity_type | text | |
| entity_id | uuid | |
| payload | jsonb | full row snapshot |
| created_at | timestamptz | |

## RLS
- All tables: open read + write in v1 (demo-first)
- Sprint 3: replace with `auth.uid() = user_id` owner policies on ideas, signups, core_actions
- audit_logs: append-only; no delete policy ever
