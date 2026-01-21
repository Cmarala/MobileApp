# Project Context for Copilot

This is an Android-only Flutter app for an offline-first election survey system.

## What already exists
- A Windows SuperAdmin app already manages:
  - Campaign creation
  - Geo hierarchy (Campaign → Division → Mandal → Booth)
  - Bulk voter upload
  - Survey, questions, and options creation
  - Passcode generation for Admins and Volunteers
- Mobile app is ONLY for execution (no configuration).

## Mobile App Users
- Volunteers (primary): collect surveys offline
- Admins (secondary): view progress, light actions

## Authentication Model
- No username/password login.
- App activation is done using:
  - Phone number
  - Passcode (generated externally)
- Passcode decides:
  - campaign_id
  - geo_unit_id
  - role (admin or volunteer)
- Users are created if phone does not already exist.

## Backend
- Supabase Postgres database already exists.
- Do NOT use Supabase Auth.
- Use simple HTTP calls to Supabase REST or RPC.
- Anon key is used from the mobile app.

## Offline & Sync
- PowerSync will be used later for offline sync.
- Do NOT implement custom sync logic.


## Coding Rules (Very Important)
- Keep code simple and readable.
- No Bloc / Riverpod / Redux.
- No dependency injection frameworks.
- Use StatefulWidget and setState.
- One screen per file.
- Avoid abstractions unless repeated twice.

## Goal
- Rapid development.
- Minimum code.
- Working app over perfect design.

## DB Schema
Refer 