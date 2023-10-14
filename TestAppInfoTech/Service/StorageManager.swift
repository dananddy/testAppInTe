//
//  StorageManager.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    
    func fetchLocalJsonData<T: Codable>(from source: String) async -> T? {
        var object: T?
        if let bundlePath = Bundle.main.path(forResource: source, ofType: "json"),
           let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
            object = try? JSONDecoder().decode(T.self, from: jsonData)
        }
        return object
    }
}
