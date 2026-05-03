import SwiftUI

// MARK: - Travel Interest Options

enum TravelInterest: String, CaseIterable, Identifiable {
    case leisure   = "Leisure & Beach"
    case adventure = "Adventure"
    case cultural  = "Cultural Tours"
    case business  = "Business Travel"
    case honeymoon = "Honeymoon"
    case family    = "Family"
    var id: String { rawValue }
    var icon: String {
        switch self {
        case .leisure:   return "sun.max.fill"
        case .adventure: return "mountain.2.fill"
        case .cultural:  return "building.columns.fill"
        case .business:  return "briefcase.fill"
        case .honeymoon: return "heart.fill"
        case .family:    return "figure.2.and.child.holdinghands"
        }
    }
}

// MARK: - Form State

@MainActor
final class ContactFormState: ObservableObject {
    @Published var fullName     = ""
    @Published var email        = ""
    @Published var phone        = ""
    @Published var destination  = ""
    @Published var travelDate   = Date().addingTimeInterval(60 * 60 * 24 * 30)
    @Published var travelers    = 2
    @Published var interest: TravelInterest = .leisure
    @Published var message      = ""
    @Published var isSubmitting = false
    @Published var isSubmitted  = false
    @Published var errorMessage: String? = nil

    var isValid: Bool {
        !fullName.trimmingCharacters(in: .whitespaces).isEmpty &&
        email.contains("@") &&
        !destination.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func submit() {
        guard isValid else {
            errorMessage = "Please fill in your name, email, and destination."
            return
        }
        errorMessage = nil
        isSubmitting = true
        // Simulate network call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.isSubmitting = false
            self.isSubmitted  = true
        }
    }

    func reset() {
        fullName = ""; email = ""; phone = ""
        destination = ""; message = ""
        travelers = 2; interest = .leisure
        travelDate = Date().addingTimeInterval(60 * 60 * 24 * 30)
        isSubmitted = false
        errorMessage = nil
    }
}

// MARK: - Contact View

struct ContactView: View {
    @StateObject private var form = ContactFormState()
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case name, email, phone, destination, message
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.offWhite.ignoresSafeArea()

                if form.isSubmitted {
                    successView
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            formHeader
                            formBody
                                .padding(.horizontal, 20)
                                .padding(.bottom, 40)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: Header

    private var formHeader: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [Color.brandNavyDark, Color.brandNavy],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 200)

            VStack(spacing: 10) {
                Text("BOOK YOUR TRIP")
                    .font(.brandSans(size: 11, weight: .bold))
                    .kerning(1.4)
                    .foregroundColor(.white.opacity(0.65))

                Text("Plan Your\nPerfect Journey")
                    .font(.custom("PlayfairDisplay-Bold", size: 28))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text("Fill in the details below and our team will craft your tailored itinerary within 24 hours.")
                    .font(.brandSans(size: 13))
                    .foregroundColor(.white.opacity(0.70))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            .padding(.bottom, 28)
        }
    }

    // MARK: Form Body

    private var formBody: some View {
        VStack(spacing: 20) {
            // ── Contact Info ──────────────────────────────────────────
            FormSection(title: "Contact Information", icon: "person.fill") {
                VStack(spacing: 14) {
                    BrandTextField(
                        label: "Full Name *",
                        placeholder: "e.g. Sarah Connor",
                        text: $form.fullName
                    )
                    .focused($focusedField, equals: .name)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .email }

                    BrandTextField(
                        label: "Email Address *",
                        placeholder: "you@example.com",
                        text: $form.email,
                        keyboardType: .emailAddress
                    )
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .phone }
                    .autocapitalization(.none)

                    BrandTextField(
                        label: "Phone Number",
                        placeholder: "+1 (555) 000-0000",
                        text: $form.phone,
                        keyboardType: .phonePad
                    )
                    .focused($focusedField, equals: .phone)
                }
            }

            // ── Trip Details ───────────────────────────────────────────
            FormSection(title: "Trip Details", icon: "globe.americas.fill") {
                VStack(spacing: 14) {
                    BrandTextField(
                        label: "Dream Destination *",
                        placeholder: "e.g. Bali, Paris, Maldives…",
                        text: $form.destination
                    )
                    .focused($focusedField, equals: .destination)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .message }

                    // Date picker
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Planned Departure")
                            .font(.brandSans(size: 12, weight: .semibold))
                            .foregroundColor(.gray700)
                        DatePicker(
                            "",
                            selection: $form.travelDate,
                            in: Date()...,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .accentColor(.brandRed)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray300, lineWidth: 1)
                        )
                    }

                    // Travelers stepper
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Number of Travelers")
                            .font(.brandSans(size: 12, weight: .semibold))
                            .foregroundColor(.gray700)
                        Stepper(
                            "\(form.travelers) \(form.travelers == 1 ? "Traveler" : "Travelers")",
                            value: $form.travelers,
                            in: 1...30
                        )
                        .font(.brandSans(size: 15))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray300, lineWidth: 1)
                        )
                    }
                }
            }

            // ── Travel Interest ────────────────────────────────────────
            FormSection(title: "Travel Interest", icon: "star.fill") {
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 10
                ) {
                    ForEach(TravelInterest.allCases) { interest in
                        InterestChip(
                            interest: interest,
                            isSelected: form.interest == interest
                        ) {
                            form.interest = interest
                        }
                    }
                }
            }

            // ── Message ───────────────────────────────────────────────
            FormSection(title: "Additional Notes", icon: "text.bubble.fill") {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Anything else we should know?")
                        .font(.brandSans(size: 12, weight: .semibold))
                        .foregroundColor(.gray700)
                    TextEditor(text: $form.message)
                        .font(.brandSans(size: 15))
                        .focused($focusedField, equals: .message)
                        .frame(minHeight: 100)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray300, lineWidth: 1)
                        )
                }
            }

            // ── Error message ─────────────────────────────────────────
            if let error = form.errorMessage {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.brandRed)
                    Text(error)
                        .font(.brandSans(size: 13))
                        .foregroundColor(.brandRed)
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.brandRedLight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            // ── Submit Button ─────────────────────────────────────────
            Button(action: form.submit) {
                HStack(spacing: 10) {
                    if form.isSubmitting {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .scaleEffect(0.85)
                    }
                    Text(form.isSubmitting ? "Sending…" : "Send My Enquiry")
                        .font(.brandSans(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    if !form.isSubmitting {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(form.isSubmitting ? Color.brandRed.opacity(0.7) : Color.brandRed)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color.brandRed.opacity(0.35), radius: 10, x: 0, y: 4)
            }
            .disabled(form.isSubmitting)

            // Contact info footer
            contactInfoFooter
        }
        .padding(.top, 24)
    }

    // MARK: Contact Info Footer

    private var contactInfoFooter: some View {
        VStack(spacing: 12) {
            Divider()
            Text("Or reach us directly")
                .font(.brandSans(size: 12))
                .foregroundColor(.gray500)

            HStack(spacing: 20) {
                Link(destination: URL(string: "tel:+10000000000")!) {
                    Label("+1 (000) 000-0000", systemImage: "phone.fill")
                        .font(.brandSans(size: 13, weight: .medium))
                        .foregroundColor(.brandNavy)
                }
                Link(destination: URL(string: "mailto:hello@packngo.com")!) {
                    Label("hello@packngo.com", systemImage: "envelope.fill")
                        .font(.brandSans(size: 13, weight: .medium))
                        .foregroundColor(.brandNavy)
                }
            }
            .padding(.bottom, 4)
        }
    }

    // MARK: Success View

    private var successView: some View {
        VStack(spacing: 28) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.brandRedLight)
                    .frame(width: 100, height: 100)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundColor(.brandRed)
            }

            VStack(spacing: 12) {
                Text("Request Sent!")
                    .font(.custom("PlayfairDisplay-Bold", size: 30))
                    .foregroundColor(.brandNavy)

                Text("Thank you, \(form.fullName.components(separatedBy: " ").first ?? "Traveler")! Our team will reach you within 24 hours with your personalized itinerary.")
                    .font(.brandSans(size: 16))
                    .foregroundColor(.gray500)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Button(action: form.reset) {
                Label("Plan Another Trip", systemImage: "arrow.counterclockwise")
                    .font(.brandSans(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 14)
                    .background(Color.brandRed)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Spacer()
        }
    }
}

// MARK: - Reusable Components

struct FormSection<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.brandRed)
                Text(title)
                    .font(.brandSans(size: 14, weight: .semibold))
                    .foregroundColor(.brandNavy)
            }
            content()
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .cardShadow()
    }
}

struct BrandTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.brandSans(size: 12, weight: .semibold))
                .foregroundColor(.gray700)
            TextField(placeholder, text: $text)
                .font(.brandSans(size: 15))
                .keyboardType(keyboardType)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color.offWhite)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray300, lineWidth: 1)
                )
        }
    }
}

struct InterestChip: View {
    let interest: TravelInterest
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: interest.icon)
                    .font(.system(size: 18))
                    .foregroundColor(isSelected ? .white : .brandNavy)
                Text(interest.rawValue
                    .components(separatedBy: " & ").first?
                    .components(separatedBy: " ").first ?? interest.rawValue)
                    .font(.brandSans(size: 11, weight: .medium))
                    .foregroundColor(isSelected ? .white : .gray700)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(isSelected ? Color.brandRed : Color.offWhite)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.brandRed : Color.gray300, lineWidth: 1)
            )
        }
        .animation(.easeInOut(duration: 0.18), value: isSelected)
    }
}

#Preview {
    ContactView()
}
