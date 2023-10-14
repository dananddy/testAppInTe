//
//  NetworkService.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation

enum NetworkError: Error {
    case badCode
    case badURL
    
    var description: String {
        switch self {
        case .badCode:
            return "Response code is not 200"
        case .badURL:
            return "Unable to create URL"
        }
    }
}

final class NetworkService {
    
    static let shared = NetworkService()
    
    func fetchData(url: String, _ endpoint: String, request: String) async throws -> Data {
        let urlString = url + endpoint + request
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode.isValidHttpCode else {
            throw NetworkError.badCode
        }
        return data
    }
}

extension Int {
    var isValidHttpCode: Bool {
        (200...299).contains(self)
    }
}
