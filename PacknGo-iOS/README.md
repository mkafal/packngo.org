# Pack'nGo — iOS App (SwiftUI)

## Project Structure

```
PacknGo-iOS/
└── PacknGo/
    ├── PacknGoApp.swift          ← App entry point (@main)
    ├── ContentView.swift         ← Tab navigation (Home / Book Now)
    ├── Theme/
    │   └── BrandTheme.swift      ← Colors, fonts, shadow modifiers
    └── Views/
        ├── HomeView.swift        ← Hero screen with stats & feature cards
        └── ContactView.swift     ← Booking enquiry form
```

## How to Open in Xcode

1. Open **Xcode** → File → New → Project
2. Choose **iOS → App**, click Next
3. Set:
   - Product Name: `PacknGo`
   - Interface: **SwiftUI**
   - Language: **Swift**
4. Save the project **inside** the `PacknGo-iOS/` folder
5. In Finder, drag all files from `PacknGo-iOS/PacknGo/` into the Xcode project navigator (replacing the generated ContentView.swift)
6. Make sure **"Copy items if needed"** is unchecked (they're already in place)
7. Hit **Run** (⌘R) on any iOS 17+ simulator

## Font Setup (Playfair Display)

The app references `PlayfairDisplay-Bold` and `PlayfairDisplay-BoldItalic`.

1. Download from [Google Fonts → Playfair Display](https://fonts.google.com/specimen/Playfair+Display)
2. Add the `.ttf` files to your Xcode project (check "Add to target")
3. In **Info.plist**, add the key `Fonts provided by application` and list each filename

> If you skip this step, the headings will fall back to system bold — the app still works.

## Minimum Requirements

- Xcode 15+
- iOS 17+ deployment target
- No third-party packages required

## Screens

| Screen | File |
|--------|------|
| Home / Hero | `Views/HomeView.swift` |
| Book Now (contact form) | `Views/ContactView.swift` |
