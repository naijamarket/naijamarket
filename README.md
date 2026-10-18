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


## Stage 2 additions

- Animated rotating homepage prompts, hover motion and reduced-motion accessibility support.
- Helpful lost-device guidance linking to official Android and Apple services. This website does not secretly track phones or locate devices from a phone number.
- Vehicle tracking guidance explaining that live tracking requires a compatible installed GPS device and authorised provider account.
- Airtime-to-cash information request UI. **No conversion, payout, payment or commission is active** until a provider is vetted and a secure server-side integration is implemented.
- Wholesale enquiry form (preview only), contact buttons, social profile slots, improved metadata for sharing/search engines and a transparent monetisation section.

## Before publishing

1. In `app.js`, fill `NAIJAMARKET_CONFIG.whatsappNumber`, `supportPhone`, `supportEmail` and each social profile URL. These are blank intentionally because the owner's actual contact details and social account URLs were not supplied. Do not publish placeholder details as if they are real.
2. For a live airtime-to-cash service, evaluate a provider, confirm its Nigerian network support, fees, settlement terms, fraud controls, refund/dispute process and legal requirements. Integrate API credentials only in a protected server/edge function, never in `app.js`. Display the provider charge and NaijaMarket commission before customer confirmation; keep a transaction ledger and reconciliation process.
3. For commissions, begin with optional promoted listings and transparent wholesale lead fees only after payment processing, terms and support are operational. Do not promise earnings or charge users for a feature that is not active.
4. Add your real production domain to canonical metadata, create a sitemap and `robots.txt`, verify the site in Google Search Console and submit the sitemap. Do not invent reviews, customer counts, discounts, or “number one in Africa” claims. Use truthful claims such as “built for buyers and sellers across Nigeria” until independent evidence supports stronger statements.
5. Connect forms to Supabase using authentication, row-level security, storage rules and server-side validation before accepting real customer data. This ZIP remains a front-end prototype; forms do not persist submissions to a shared backend.
6. Only advertise social accounts you own/control. Social sharing and organic reach cannot be guaranteed by a website change alone.

## SEO references

- Google ecommerce SEO guidance: https://developers.google.com/search/docs/specialty/ecommerce
- Product structured data: https://developers.google.com/search/docs/appearance/structured-data/merchant-listing
- Android Find Hub: https://android.com/find
- Apple Find My: https://www.icloud.com/find


## Stage 3 additions — security, disclaimer and branch governance

- Added a visible Security, Rules & Nationwide Branches section, plus modal pages for security rules, a draft legal disclaimer and a planned admin hierarchy.
- Added footer shortcuts to these policy pages.
- Expanded `schema.sql` with `branch_offices` and `staff_profiles` starter tables and enabled row-level security on them. No permissive policies are included; client access is intentionally denied until a qualified developer writes and tests the correct policies/functions.
- Planned role hierarchy: `overall_owner` (platform owner), `national_admin`, `state_manager`, `branch_staff`, and `support_moderator`. State managers and branch staff must be restricted to their assigned branch/state. The owner role must be assigned only through a trusted server-side process.

### Important limitations and legal launch checklist

The security page, disclaimer, and branch dashboard description are informational front-end content, not proof that security controls are active. This website is still a prototype. Before accepting real users or money, implement and test Supabase Auth, server-side role enforcement, row-level security policies, secure storage policies, rate limiting, email/phone verification, staff MFA, audit logging, backups, moderation queues, incident response, privacy controls, account appeals and secure payment-provider integrations. Never put a Supabase service-role key or other secret in browser JavaScript.

The disclaimer is a **draft template, not legal advice and not a guarantee against liability**. Have a qualified Nigerian lawyer adapt it to the actual operator/business, services, consumer rights, privacy/data protection, prohibited items, user-generated content, payments, commissions, disputes, refunds and applicable law before launch. A disclaimer cannot legalise unlawful activity or remove obligations that law does not allow a business to exclude.

Do not promise users that every seller or listing is verified unless a real, documented verification process supports that statement. A report is an allegation, not proof. Investigate fairly, preserve evidence appropriately, restrict staff access to private data, and offer a correction/appeal route where appropriate.


## Stage 4 FAQ update
The homepage now includes a Frequently Asked Questions section covering browsing and sample listings, posting and moderation, scam reports, payments and commissions, airtime conversion, authorised device/vehicle tracking, state branch roles, account/data security, appeals, support and the legal disclaimer. Answers explicitly distinguish planned features from live functionality. The FAQ uses native HTML `details`/`summary` elements so it works without a JavaScript framework and supports keyboard interaction.

## Stage 5 visual and advertising upgrade

This version adds a Nigeria-inspired green/white visual theme, a moving highlights ticker, gentle floating hero cards, subtle animated backgrounds, and motion on promotional elements. Animations respect the user's `prefers-reduced-motion` accessibility setting.

A new advertising section contains clearly labelled placeholder spaces for brand banners, sponsored business cards, and featured listings. The advertising enquiry form is a front-end preview only: it does not save an enquiry or create an advert booking unless an official WhatsApp number is configured, in which case it opens a pre-filled WhatsApp message for the user to send. Advertising prices, terms, approval, and payment processing still need to be configured before launch.

The support area includes an original inline vector illustration and a help-centre preview. It does not create a live support ticket. Configure and test the official support contacts and backend before inviting customers to rely on them.

Do not describe the animation, advertising placeholders, sample listings, support preview, or contact enquiry as a live service until the production implementation is completed and tested.


## Stage 6: customer, agent, overall manager and earnings-room preview

This version adds a customer signup screen, a separate agent application screen for Nigeria's 36 states and the FCT, a manager-only sign-in screen (no public manager registration), and a clearly labelled agent earnings-room preview. These screens are front-end previews only. They do not create accounts, authenticate the owner, approve agents, hold funds, calculate real commissions, or pay withdrawals until Supabase Auth, server-side authorization, reviewed RLS policies, secure manager provisioning and trusted payment/ledger functions are implemented and tested.

The SQL schema adds `agent_applications`, `agent_profiles`, and `agent_wallet_ledger`. Row Level Security is enabled and no permissive client policies are included intentionally. Do not expose a Supabase service-role key in browser JavaScript. Create the overall owner using a trusted setup process; never allow a public signup form to assign `overall_owner` or any privileged role. Enable MFA for the owner and staff, use a unique strong password, keep recovery codes securely offline, configure rate limits and alerts, and test account recovery and branch isolation. No website can honestly promise that it is impossible to hack.


## Stage 7 visual updates
- Added a Nigeria-inspired city/flag visual to the hero background with gentle motion.
- Added the supplied portrait as the welcome guide and customer-support host.
- Added an animated welcome prompt with Buy and Sell links.
- Animations adapt to mobile layouts and respect reduced-motion accessibility settings.
- Images are bundled locally in `assets/` so they are included in the ZIP.
- Manager, agent, customer authentication and money/commission features remain preview-only until secure Supabase backend permissions and payment processing are implemented.
