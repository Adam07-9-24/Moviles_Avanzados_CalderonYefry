import SwiftUI
import FirebaseCore

@main
struct Lab14IntroFirebaseApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
