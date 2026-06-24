# PRD — mvpid

## Problem
Entrepreneurs have business ideas but no fast, structured way to test if real people will sign up and take a meaningful action before building anything. They waste weeks on products nobody wants.

## Target User
Solo founder or early-stage entrepreneur who needs demand validation **this week**, not next quarter.

## Core Objects
- **Idea** — the thing being validated (pitch, core action label, demand score)
- **Signup** — a real person who registered interest (name, email, intent)
- **Core Action** — the single demand-test action a visitor completes (e.g. "Start my free trial")
- **Activity** — event log of every meaningful interaction
- **Audit Log** — immutable record of all writes

## MVP Must-Haves (v1)
- [ ] Landing page renders idea pitch for anonymous visitors — no login required
- [ ] Signup form (name, email, intent) persists to DB and shows confirmation
- [ ] Core action form persists completion to DB
- [ ] Live signup count + action count visible on landing page
- [ ] /admin page lists all signups and action completions
- [ ] Rule-based demand score displayed on admin page
- [ ] Empty, loading, and error states on all forms

## Non-Goals (v1)
- User authentication / login wall
- Multiple ideas per builder
- Email notifications
- AI-generated summaries
- Mobile app

## Success Criteria
**End-to-end scenario:** A stranger opens the landing page URL, reads the pitch, fills in the signup form, completes the core action, and the builder sees their name, email, intent, and action logged in /admin with an updated demand score — all without either person creating an account.
