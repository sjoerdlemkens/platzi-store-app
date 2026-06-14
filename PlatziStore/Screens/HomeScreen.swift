import SwiftUI

struct HomeScreen: View {
    @Environment(\.authenticationController) private var authenticationController
    var body: some View {
        Button("Sign out") {
            authenticationController.signOut()
        }
    }
}

#Preview {
    HomeScreen()
}
