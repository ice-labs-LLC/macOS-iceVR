import SwiftUI
 
@main
struct iceVRApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            AboutCommands()
        }
 
        WindowGroup("About iceVR", id: "about-icevr") {
            AboutView()
        }
        .windowResizability(.contentSize)   // locks to the view's exact size
        .defaultSize(width: 460, height: 480)
    }
}
 
private struct AboutCommands: Commands {
    @Environment(\.openWindow) private var openWindow
 
    var body: some Commands {
        CommandGroup(replacing: .appInfo) {
            Button("About iceVR") {
                openWindow(id: "about-icevr")
            }
        }
    }
}
 
private struct AboutView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.03, green: 0.20, blue: 0.74),
                    Color(red: 0.18, green: 0.54, blue: 0.97),
                    Color(red: 0.97, green: 0.82, blue: 0.18),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
 
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color.white.opacity(0.18))
                        .frame(width: 120, height: 120)
 
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .font(.system(size: 54, weight: .black))
                        .foregroundStyle(.white)
                }
 
                Text("iceVR")
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
 
                Text("ice labs 2024-2026")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .textCase(.uppercase)
                    .tracking(4)
                    .foregroundStyle(Color.white.opacity(0.9))
 
                Text("Custom About screen for the macOS app menu while the Quest and Pico linking flow is still under construction.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white.opacity(0.82))
                    .frame(maxWidth: 360)
            }
            .padding(32)
        }
        // Pin the view itself to exactly 460×480 so .contentSize has nothing to negotiate
        .frame(width: 460, height: 480)
    }
}
