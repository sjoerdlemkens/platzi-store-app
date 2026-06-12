import SwiftUI

struct RegistrationScreen: View {
    @Environment(\.authenticationController) private var authenticationController
    
    @State private var registrationForm = RegistrationForm()
    @State private var errors: [String] = []
    @State private var messageText: String?
    
    private func register() async {
        do {
            print("hi")
            print(registrationForm)
            let response =  try await authenticationController.register(
                name: registrationForm.name,
                email: registrationForm.email,
                password: registrationForm.password
            )
            
            messageText = "Registration for user \(response.name) is completed"
            
        } catch {
            print(error)
            messageText = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $registrationForm.name)
            TextField("Email", text: $registrationForm.email)
            SecureField("Password", text: $registrationForm.password)
            Button("Register") {
                Task{ await register() }
            }.disabled(!registrationForm.isValid)
            
            if let messageText {
                Text(messageText)
                    .multilineTextAlignment(.center)
            }
         
        }
    }
}

extension RegistrationScreen {
    private struct RegistrationForm {
        var name: String = "John Doe"
        var email: String = "johndoe@gmail.com"
        var password: String = "password1234"
        
        var isValid: Bool {
            validate().isEmpty
        }
        
        func validate() -> [String] {
            var errors: [String] = []
            
            if name.isEmptyOrWhitespace {
                errors.append("Name cannot be empty")
            }
            
            if email.isEmptyOrWhitespace {
                errors.append("Email cannot be empty")
            }
            
            if password.isEmptyOrWhitespace {
                errors.append("Password cannot be empty")
            }
            
            if !password.isValidPassword {
                errors.append("Password must be at least 8 characters long.")
            }
            
            if !email.isEmail {
                errors.append("Password must be at least 8 characters long.")
            }
            
            return errors
        }
    }
}

#Preview {
    RegistrationScreen()
}
