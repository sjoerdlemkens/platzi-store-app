import Foundation

struct AuthenticationController {
    // If mocking then use HTTPClientProtocol
    let httpClient: HTTPClient
    
    func register(name: String, email: String, password: String) async throws -> RegistrationResponse {
        let registrationResponse =  try await httpClient.register(name: name, email: email, password: password, avatar: URL(string: "https://picsum.photos/800")!)
        
        return registrationResponse
    }
}
