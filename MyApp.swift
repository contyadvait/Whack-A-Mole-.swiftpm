import SwiftUI

@main
struct MyApp: App {
    @StateObject var gameManager = GameOpening()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameManager)
        }
    }
}
