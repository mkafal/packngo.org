# Pack'nGo — Mobile App (React Native + Expo)

Works on **iOS and Android**. No Mac or Xcode required.

---

## What You Need (free installs)

| Tool | Link | Why |
|------|------|-----|
| Node.js (LTS) | https://nodejs.org | Runs the project |
| VS Code | https://code.visualstudio.com | Code editor (optional but recommended) |
| Expo Go (phone app) | App Store / Google Play | Preview the app live on your phone |

---

## How to Run (3 steps)

**1. Install dependencies**
Open a terminal in this folder (`PacknGo-App/`) and run:
```
npm install
```

**2. Start the app**
```
npm start
```

**3. Open on your phone**
- A QR code will appear in the terminal
- Open the **Expo Go** app on your phone and scan it
- The app loads instantly — hot-reloads as you edit code

---

## Project Structure

```
PacknGo-App/
├── App.js                        ← Entry point, tab navigation
├── app.json                      ← App name, icon, config
├── package.json                  ← Dependencies
└── src/
    ├── theme/
    │   └── colors.js             ← Brand colors (mirrors web CSS tokens)
    └── screens/
        ├── HomeScreen.js         ← Hero, stats, features, CTA
        └── ContactScreen.js      ← Booking form with validation
```

## Screens

- **Home** — Hero with gradient overlay, stats bar, feature cards, CTA banner
- **Book Now** — Full enquiry form: name, email, destination, traveler count, interests, message, success state

## Brand Identity

Colors, gradient directions, and layout match the Pack'nGo web landing page exactly:
- Primary Red: `#CC2033`
- Navy: `#1B3A6B`
- Accent: `#ffd0d6` / `#ff8a97`
