// 
// APIManager.swift
// Rick and Morty Revealed
// 

import Foundation

class APIManager {
    private init() {}
    static let shared = APIManager()
    
    enum Method: String {
        case get
        case post
    }
    
    struct EmptyRequest: Encodable {}
    
    func perform<Request, Response>(
        _ route: Route,
        method: Method = .get,
        body: Request? = nil
    ) async throws -> Response where Request: Encodable, Response: Decodable {
        return try await perform(
            url: route.url,
            method: method,
            body: body
        )
    }
    
    func perform<Request, Response>(
        url: URL,
        method: Method = .get,
        body: Request? = nil
    ) async throws -> Response where Request: Encodable, Response: Decodable {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body {
            request.httpBody = try endocer.encode(body)
        }
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(Response.self, from: data)
    }
    
    func get<Response>(_ route: Route) async throws -> Response where Response: Decodable {
        let body: EmptyRequest? = nil
        return try await perform(route, body: body)
    }
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [
                .withInternetDateTime,
                .withFractionalSeconds
            ]
            return formatter.date(from: dateString)!
        }
        return decoder
    }()
    
    private let endocer = JSONEncoder()
}
