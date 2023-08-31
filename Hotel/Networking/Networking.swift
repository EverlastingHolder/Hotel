import Foundation

final class Networking {
    private let baseURL: String = "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
    private let session: URLSession = .shared
    private let decode: JSONDecoder = .init()
    
    func request<T: Codable>(
        _ path: String,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        query: [String: String?] = [:],
        parameters: [String: Any] = [:]
    ) async -> APIResult<T> {
        var request = URLRequest(url: URL(string: baseURL + path)!)
        request.httpMethod = method.rawValue
        request.url?.append(queryItems: query.map {
            URLQueryItem(name: $0, value: $1)
        })
        if method != .get {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            } catch {
                print("Error JSONSerialization")
            }
            
        }
        print(request)
    
        return await response(request: request)
    }
    
    private func response<T: Codable>(request: URLRequest) async -> APIResult<T> {
        do {
            let (data, _) = try await session.data(for: request)
            return try .success(decode.decode(T.self, from: data))
        } catch(let error) {
            print(error)
            return .error
        }
    }
}
