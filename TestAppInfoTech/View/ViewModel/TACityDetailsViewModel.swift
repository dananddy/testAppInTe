//
//  TACityDetailsViewModel.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation

enum MinMaxTempType {
    case min
    case max
}

final class TACityDetailsViewModel {
    let lat: Double
    let lon: Double
    let name: String?
    let description: String?
    let temp: String?
    let minMaxTemp: [MinMaxTempType: String?]
    let humidity: String?
    let windSpeed: String?
    
    init(name: String?,
         lat: Double,
         lon: Double,
         description: String?,
         temp: String?,
         minMaxTemp: [MinMaxTempType : String?],
         humidity: String?,
         windSpeed: String?) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.description = description
        self.temp = temp
        self.minMaxTemp = minMaxTemp
        self.humidity = humidity
        self.windSpeed = windSpeed
    }
}
