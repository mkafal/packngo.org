import SwiftUI

// MARK: - Brand Colors (mirrors web landing page CSS tokens)

extension Color {
    static let brandRed      = Color(hex: "#CC2033")
    static let brandRedDark  = Color(hex: "#a81829")
    static let brandRedLight = Color(hex: "#f5e8ea")
    static let brandNavy     = Color(hex: "#1B3A6B")
    static let brandNavyDark = Color(hex: "#122850")
    static let brandNavyLight = Color(hex: "#2a5299")
    static let offWhite      = Color(hex: "#f8f9fb")
    static let gray100       = Color(hex: "#f1f3f7")
    static let gray300       = Color(hex: "#d1d5de")
    static let gray500       = Color(hex: "#6b7280")
    static let gray700       = Color(hex: "#374151")
    static let gray900       = Color(hex: "#111827")
    static let heroAccent    = Color(hex: "#ffd0d6")
    static let statAccent    = Color(hex: "#ff8a97")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red:   Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Typography

extension Font {
    /// Playfair Display — headlines
    static func brandSerif(size: CGFloat, weight: Font.Weight = .bold) -> Font {
        .custom("PlayfairDisplay-Bold", size: size)
    }
    /// Inter — body / UI
    static func brandSans(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

// MARK: - Shadow Modifiers

struct CardShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.10), radius: 16, x: 0, y: 4)
    }
}

extension View {
    func cardShadow() -> some View { modifier(CardShadow()) }
}
