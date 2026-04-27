import SwiftUI

struct ContentView: View {
    @AppStorage("questAddress") private var savedQuestAddress = ""
    @AppStorage("picoAddress") private var savedPicoAddress = ""

    @State private var questAddress = ""
    @State private var picoAddress = ""
    @State private var statusMessage = "Enter any Quest or Pico target for now. Validation and real device linking can come later."

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.18, blue: 0.72),
                    Color(red: 0.14, green: 0.49, blue: 0.97),
                    Color(red: 0.98, green: 0.84, blue: 0.16),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("iceVR")
                        .font(.system(size: 52, weight: .black, design: .rounded))
                        .foregroundStyle(.white)

                    Text("Quest & Pico Link Setup")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color.white.opacity(0.95))

                    Text("This placeholder screen accepts any text while the rest of the project is still being built.")
                        .foregroundStyle(Color.white.opacity(0.82))
                        .fixedSize(horizontal: false, vertical: true)
                }

                VStack(alignment: .leading, spacing: 18) {
                    linkField(
                        title: "Quest IP",
                        prompt: "192.168.1.15 or any placeholder text",
                        text: $questAddress,
                        savedValue: savedQuestAddress,
                        saveAction: saveQuest
                    )

                    linkField(
                        title: "Pico IP",
                        prompt: "192.168.1.22 or any placeholder text",
                        text: $picoAddress,
                        savedValue: savedPicoAddress,
                        saveAction: savePico
                    )
                }

                VStack(alignment: .leading, spacing: 12) {
                    Label("Status", systemImage: "network")
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text(statusMessage)
                        .foregroundStyle(Color.white.opacity(0.82))
                        .fixedSize(horizontal: false, vertical: true)

                    if !savedQuestAddress.isEmpty || !savedPicoAddress.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            if !savedQuestAddress.isEmpty {
                                Text("Saved Quest target: \(savedQuestAddress)")
                            }
                            if !savedPicoAddress.isEmpty {
                                Text("Saved Pico target: \(savedPicoAddress)")
                            }
                        }
                        .font(.subheadline)
                        .foregroundStyle(Color.white.opacity(0.92))
                        .textSelection(.enabled)
                    }
                }

                Spacer()
            }
            .padding(30)
            .frame(maxWidth: 760, alignment: .leading)
            .background(.ultraThinMaterial.opacity(0.35), in: RoundedRectangle(cornerRadius: 28, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .stroke(Color.white.opacity(0.22), lineWidth: 1.2)
            )
            .padding(28)
        }
        .frame(minWidth: 900, minHeight: 560)
        .onAppear {
            questAddress = savedQuestAddress
            picoAddress = savedPicoAddress
        }
    }

    private func linkField(
        title: String,
        prompt: String,
        text: Binding<String>,
        savedValue: String,
        saveAction: @escaping () -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)

            TextField(prompt, text: text)
                .textFieldStyle(.roundedBorder)

            HStack(spacing: 12) {
                Button("Save", action: saveAction)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.09, green: 0.28, blue: 0.84))
                    .disabled(text.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                if !savedValue.isEmpty {
                    Button("Use Saved Value") {
                        text.wrappedValue = savedValue
                        statusMessage = "Loaded saved \(title.lowercased())."
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding(20)
        .background(Color.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private func saveQuest() {
        let trimmedAddress = questAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedAddress.isEmpty else { return }

        savedQuestAddress = trimmedAddress
        statusMessage = "Quest placeholder target saved as '\(trimmedAddress)'."
    }

    private func savePico() {
        let trimmedAddress = picoAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedAddress.isEmpty else { return }

        savedPicoAddress = trimmedAddress
        statusMessage = "Pico placeholder target saved as '\(trimmedAddress)'."
    }
}
