# Intelligence Layer — mvpid

## Messy Inputs
- Free-text `intent` field from signup form ("I need this for my Shopify store")
- `action_data` JSON from core action form (open-ended depending on idea)
- Raw counts: signups, actions, repeat visits

## Auto-Structure Schema (example)
```json
{
  "idea_id": "a1b2c3d4-...",
  "signal_strength": "high",
  "top_intent_themes": ["cost", "ease-of-setup", "existing-pain"],
  "demand_score": 14,
  "sellability_flag": "Signal detected",
  "scalability_flag": "Possible",
  "ai_summary": "Early adopters cite pricing pain and fast setup as primary drivers.",
  "ai_summary_confidence": 0.82,
  "ai_summary_review_status": "unreviewed"
}
```

## Events to Track
- `signup.created` — +1 demand point
- `core_action.completed` — +3 demand points
- `page.viewed` — passive signal (future)
- `signup.high_intent` — intent text contains buying language (future)

## Scoring Rules (rule-based first)
```
demand_score = (signup_count × 1) + (core_action_count × 3)
sellability_flag:
  score >= 10 → "Signal detected"
  score >= 4  → "Early signal"
  else        → "unscored"
```

## What Gets Ranked
- Ideas ranked by `demand_score` (Sprint 2 admin view)
- Signups ranked by intent quality (Sprint 5, AI-assisted)

## v1 vs Later
- **v1:** rule-based demand score, sellability flag — no AI needed
- **Later (Sprint 5):** AI summary of intent themes, confidence score, builder review UI
