import SwiftUI

// MARK: - Hero Stats Model

struct HeroStat: Identifiable {
    let id = UUID()
    let number: String
    let suffix: String
    let label: String
}

// MARK: - Why Choose Us Feature

struct Feature: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
}

// MARK: - Home View

struct HomeView: View {

    private let stats: [HeroStat] = [
        HeroStat(number: "50", suffix: "K+", label: "Happy Travelers"),
        HeroStat(number: "120",  suffix: "+",  label: "Destinations"),
        HeroStat(number: "15",   suffix: "yr", label: "Experience"),
        HeroStat(number: "4.9",  suffix: "★",  label: "Avg Rating"),
    ]

    private let features: [Feature] = [
        Feature(icon: "shield.checkered",
                title: "Safe & Trusted",
                description: "IATA-certified agency with 15 years of flawless operations across 120+ countries."),
        Feature(icon: "tag.fill",
                title: "Best Price Guarantee",
                description: "We match or beat any comparable offer — your dream trip shouldn't cost a fortune."),
        Feature(icon: "headphones",
                title: "24 / 7 Support",
                description: "Our multilingual team is always on standby, wherever in the world you may be."),
        Feature(icon: "map.fill",
                title: "Tailored Itineraries",
                description: "Every journey is built around you — interests, pace, budget, and travel style."),
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                heroSection
                statsBar
                whyUsSection
                ctaBanner
            }
        }
        .ignoresSafeArea(edges: .top)
    }

    // MARK: Hero

    private var heroSection: some View {
        ZStack(alignment: .bottom) {
            // Background gradient (mirrors landing page linear-gradient over image)
            LinearGradient(
                colors: [
                    Color.brandNavy.opacity(0.85),
                    Color.brandRed.opacity(0.78)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 520)
            .overlay(
                AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&q=80")) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFill()
                    }
                }
                .blendMode(.multiply)
                .clipped()
            )
            .clipped()

            // Content
            VStack(spacing: 0) {
                Spacer()

                // Eyebrow pill
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.statAccent)
                        .frame(width: 7, height: 7)
                    Text("PREMIUM TRAVEL AGENCY")
                        .font(.brandSans(size: 11, weight: .bold))
                        .kerning(1.4)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial.opacity(0.6))
                .clipShape(Capsule())
                .padding(.bottom, 24)

                // Headline
                VStack(spacing: 12) {
                    Text("Fly Your")
                        .font(.custom("PlayfairDisplay-Bold", size: 46))
                        .foregroundColor(.white)
                    Text("Dreams")
                        .font(.custom("PlayfairDisplay-BoldItalic", size: 46))
                        .foregroundColor(.heroAccent)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)

                // Subheadline
                Text("Crafting unforgettable journeys across 120+ destinations — tailor-made for every traveler.")
                    .font(.brandSans(size: 16))
                    .foregroundColor(.white.opacity(0.82))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)

                // CTA buttons
                HStack(spacing: 12) {
                    NavigationLink(destination: ContactView()) {
                        Label("Book Now", systemImage: "paperplane.fill")
                            .font(.brandSans(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                            .background(Color.brandRed)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    Button {
                        // Scroll to features
                    } label: {
                        Label("Explore", systemImage: "globe")
                            .font(.brandSans(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 13)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white.opacity(0.6), lineWidth: 1.5)
                            )
                    }
                }
                .padding(.bottom, 48)
            }
            .frame(height: 520)

            // Bottom fade
            LinearGradient(colors: [.white, .clear], startPoint: .bottom, endPoint: .top)
                .frame(height: 60)
        }
    }

    // MARK: Stats Bar

    private var statsBar: some View {
        HStack(spacing: 0) {
            ForEach(Array(stats.enumerated()), id: \.offset) { index, stat in
                VStack(spacing: 4) {
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text(stat.number)
                            .font(.brandSans(size: 22, weight: .heavy))
                            .foregroundColor(.brandNavy)
                        Text(stat.suffix)
                            .font(.brandSans(size: 14, weight: .bold))
                            .foregroundColor(.brandRed)
                    }
                    Text(stat.label)
                        .font(.brandSans(size: 11))
                        .foregroundColor(.gray500)
                }
                .frame(maxWidth: .infinity)

                if index < stats.count - 1 {
                    Divider()
                        .frame(height: 36)
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 8)
        .background(Color.white)
        .cardShadow()
        .padding(.horizontal, 20)
        .padding(.top, -20)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: Why Choose Us

    private var whyUsSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Section header
            VStack(alignment: .leading, spacing: 10) {
                Text("WHY PACKNGO")
                    .font(.brandSans(size: 11, weight: .bold))
                    .kerning(1.4)
                    .foregroundColor(.brandRed)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 5)
                    .background(Color.brandRedLight)
                    .clipShape(Capsule())

                Text("Travel Smarter,\nExperience More")
                    .font(.custom("PlayfairDisplay-Bold", size: 28))
                    .foregroundColor(.brandNavy)
                    .lineSpacing(4)

                Text("We handle every detail so you can focus on making memories.")
                    .font(.brandSans(size: 15))
                    .foregroundColor(.gray500)
            }
            .padding(.horizontal, 20)
            .padding(.top, 36)

            // Feature cards
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 14
            ) {
                ForEach(features) { feature in
                    FeatureCard(feature: feature)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 36)
    }

    // MARK: CTA Banner

    private var ctaBanner: some View {
        ZStack {
            LinearGradient(
                colors: [Color.brandNavyDark, Color.brandNavy],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 20) {
                Text("Ready to Fly\nYour Dream?")
                    .font(.custom("PlayfairDisplay-Bold", size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text("Get a personalized quote from our travel experts — no commitment required.")
                    .font(.brandSans(size: 14))
                    .foregroundColor(.white.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                NavigationLink(destination: ContactView()) {
                    Label("Get a Free Quote", systemImage: "arrow.right.circle.fill")
                        .font(.brandSans(size: 15, weight: .semibold))
                        .foregroundColor(.brandNavy)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.vertical, 48)
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Feature Card

private struct FeatureCard: View {
    let feature: Feature

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: feature.icon)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.brandRed)
                .frame(width: 44, height: 44)
                .background(Color.brandRedLight)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(feature.title)
                .font(.brandSans(size: 14, weight: .semibold))
                .foregroundColor(.brandNavy)

            Text(feature.description)
                .font(.brandSans(size: 12))
                .foregroundColor(.gray500)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .cardShadow()
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
