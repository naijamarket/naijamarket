# NaijaMarket Pro — Nigeria-first marketplace starter

This is a polished responsive **front-end prototype** for NaijaMarket. It is designed around the business model discussed: people across Nigeria submit listings for free, the owner reviews and edits them, public buyers contact the marketplace number first, and the owner coordinates between buyer and seller.

## Included in this package

- Responsive Nigeria-inspired green, white and flag-themed design
- Search, category filtering, state filtering and price sorting
- Listing submission form for members of the public
- Pending-review flow: submitted listings are not publicly visible until approved
- Demo admin dashboard: approve, edit, reject/remove listings; view reports; block submitter emails
- Public buyer-enquiry flow intended to use the owner's WhatsApp number
- Suspicious-listing report form
- `supabase/schema.sql` starter database schema with row-level security concepts

## Important: prototype vs live marketplace

This download is **not yet a production website**. The current demo stores submissions and reports in the visitor's own browser. That means a post made on one phone does not automatically appear on another phone. The demo admin login is intentionally not configured by default. Browser-only controls cannot securely protect an admin dashboard on a public website.

Before inviting the public, connect a real backend (the supplied SQL is a starting point), implement Supabase Auth, storage for uploaded photos, server-side policies, admin alerts, spam protection and test the permissions. Never put a Supabase service-role key or any secret in `app.js`.

## Preview locally

1. Extract the ZIP.
2. Open `index.html` in a modern browser. Some browser restrictions may affect images; use a local web server or GitHub Pages for a better preview.
3. The sample listings are illustrative examples. Remove/replace them with real listings that you have permission to advertise.

## Set your WhatsApp number

Open `app.js`, find:

```js
whatsappNumber: "",
```

Enter your number in international digits only, with no plus sign or spaces. Example format: `2348012345678`. Do not use that example number as your own. Buyers should be routed to your marketplace contact, not the seller's private number.

## Admin access

The demo's local login accepts credentials only after you set `adminEmail` and `adminPassword` in `app.js`. This is **for local preview only** and is not safe for a public website. Anyone can inspect front-end JavaScript. For the live version, use Supabase Auth and database Row Level Security so only your authenticated admin account can approve/edit/remove listings, view private seller contacts, manage reports and block submitters.

## Suggested launch plan

1. Start with Abuja/FCT listings and clearly identify locations across Nigeria.
2. Collect seller permission and details, then verify what you reasonably can before approval.
3. Keep the seller's phone private; buyers contact your marketplace number first.
4. Give the admin dashboard a private queue for pending listings and scam reports.
5. Notify the admin of new submissions/reports (email or another secure notification method).
6. Publish the website first. Once the marketplace and backend work reliably, build an Android app that uses the same backend.

## Scam prevention limits

No website can guarantee every listing or seller is genuine. Use reports as signals, investigate before blocking, preserve relevant evidence, remove suspicious posts quickly and display reminders to inspect items and verify property title/ownership independently. Do not label someone a scammer solely because an unverified report was submitted.

## Folder contents

- `index.html` — page structure and forms
- `style.css` — responsive visual design
- `app.js` — interactive demo behaviour
- `supabase/schema.sql` — initial database schema and policy notes


## Account-first posting and admin verification flow (new in this version)

- Visitors must create a demo account or log in before they can submit a listing.
- Submissions are saved as `pending`, and do not appear in the public listing grid until approved.
- The demo admin panel includes buttons to mark a poster as contacted and commission terms as agreed.
- The demo prevents approval of a user-submitted listing until both steps are marked.
- Public buyers are intended to contact the marketplace number, not the seller directly.
- A customer-support widget preview answers common questions about posting, approval, buyer contact and reporting.

### Production requirements before opening registration

The account and admin actions in this prototype are browser-only demonstrations. Do not use this version's demo accounts to protect real personal data. For a public launch, implement:
- Supabase Auth with email verification and phone OTP if phone-number sign-in is required.
- Server-side authorization and row-level security; only your owner account can review, edit, approve, remove, or block.
- A database record for verification/contact outcome, agreed commission terms, and audit history.
- Email or secure push notifications to the admin when a new submission/report arrives.
- Secure image upload and moderation checks.
- An AI support endpoint hosted on a server/Edge Function. Keep any AI API key on the server; never put it in `app.js`. Add a human escalation route for uncertain, sensitive, payment, legal or fraud questions.
- Abuse controls, rate limits, spam prevention, privacy notice, terms, prohibited-items policy, and a process for appeals.

The AI support widget in this ZIP is a **rule-based preview**, not a connected AI model. It demonstrates the interface and common FAQ flow only. A real AI service needs a secure backend and monitoring.

## Package repair note
This ZIP contains `index.html`, `style.css`, `app.js`, and `supabase/schema.sql`. The front end is a demonstration only. Sample listings are not real offers, and account registration, listing submission, admin approval, reports, notifications, and AI support are not connected to a production backend yet. Do not collect real customer information until Supabase Auth, storage, database policies, admin permissions, and server-side validation have been implemented and tested.
