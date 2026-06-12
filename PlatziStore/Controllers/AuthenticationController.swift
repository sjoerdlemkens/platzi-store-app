import Foundation

struct AuthenticationController {
    // If mocking then use HTTPClientProtocol
    let httpClient: HTTPClient
    
    func register(name: String, email: String, password: String) async throws -> RegistrationResponse {
        let registrationResponse =  try await httpClient.register(name: name, email: email, password: password, avatar: URL(string: "https://picsum.photos/800")!)
        
        return registrationResponse
    }
    
    func login(email: String, password: String) async throws -> Bool {
        
        let loginResponse = try await httpClient.login(email: email, password: password)
        
        print(loginResponse.accessToken)
        print(loginResponse.refreshToken)
        
        // Save the access and refresh token in Keychain
        Keychain.set(loginResponse.accessToken, forKey: "accessToken")
        Keychain.set(loginResponse.refreshToken, forKey: "refreshToken")

        return true
    }
}
