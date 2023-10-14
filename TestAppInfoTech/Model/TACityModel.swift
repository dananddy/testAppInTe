//
//  TACityModel.swift
//  TestAppInfoTech
//
//  Created by busido on 13.10.2023.
//

import Foundation

class TACityModel: Codable {
    
    struct TACoordinates: Codable {
        let lon: Double
        let lat: Double
    }
    
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: TACoordinates
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.state = try container.decode(String.self, forKey: .state)
        self.country = try container.decode(String.self, forKey: .country)
        self.coord = try container.decode(TACoordinates.self, forKey: .coord)
    }
}

extension TACityModel: ITAWeatherCity {
    var lon: String {
        String(self.coord.lon)
    }
    
    var lat: String {
        String(self.coord.lat)
    }
    
    
}
