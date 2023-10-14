//
//  TAOpenWeatherSettings.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation

class TAOpenWeatherSettings {
    let url: String
    let endpoint: String
    let apiKey: String
    
    init(url: String,
         endpoint: String,
         apiKey: String) {
        self.url = url
        self.endpoint = endpoint
        self.apiKey = apiKey
    }
}
