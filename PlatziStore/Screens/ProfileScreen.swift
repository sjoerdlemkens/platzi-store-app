import SwiftUI

struct ProfileScreen: View {
    @Environment(\.authenticationController) private var authenticationController
    
    var body: some View {
        Button(action: {
            authenticationController.signOut()
        }){
            Text("Sign out")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red.opacity(0.1))
                .foregroundColor(.red)
                .cornerRadius(12)
        }
        .padding(.horizontal)
        .padding(.bottom, 40)
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack {
        ProfileScreen()
    }
}
