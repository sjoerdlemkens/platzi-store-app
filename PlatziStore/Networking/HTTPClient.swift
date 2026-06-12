import Foundation

struct HTTPClient {
    
    func register(name: String, email: String, password: String, avatar: URL) async throws -> RegistrationResponse {
        let registrationRequest = RegistrationRequest(name: name, email: email, password: password, avatar: URL(string: "https://picsum.photos/800")!)
        
        var request = URLRequest(url: Constants.Urls.register)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(registrationRequest)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) =  try await URLSession.shared.data(for: request)
        let registrationResponse  = try JSONDecoder().decode(RegistrationResponse.self, from: data)
        return registrationResponse
    }
}
