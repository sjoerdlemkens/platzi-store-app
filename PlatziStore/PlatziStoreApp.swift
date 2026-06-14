import SwiftUI

@main
struct PlatziStoreApp: App {
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    @Environment(\.authenticationController) private var authenticationController
    @State private var isLoading: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isLoading {
                    ProgressView("Loading...")
                        .task {
                            isAuthenticated = await authenticationController.checkAuthentication()
                            isLoading = false
                        }
                } else if isAuthenticated {
                    HomeScreen()
                        .environment(PlatziStore(httpClient: HTTPClient()))
                } else {
                    VStack {
                        RegistrationScreen()
                        LoginScreen()
                    }
                }
            }
        }
    }
}
