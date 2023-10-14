//
//  CacheManager.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation

final class CacheManager {
    private let dataCache = NSCache<NSString, NSData>()
    
    static let shared = CacheManager()
    
    func saveToCahce(_ data: Data, for key: String) {
        dataCache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func cacheLookup(from key: String) -> Data? {
        dataCache.object(forKey: key as NSString) as Data?
    }
}
