//
//  TAWeatherModel.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation

struct TAWeatherModel: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
    
    struct Clouds: Codable {
        let all: Int?
    }
    
    struct Coord: Codable {
        let lon, lat: Double?
    }
    
    struct Main: Codable {
        let temp, feelsLike, tempMin, tempMax: Double?
        let pressure, humidity, seaLevel, grndLevel: Int?
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }
    
    struct Rain: Codable {
        let h1: Double?
    }
    
    
    struct Sys: Codable {
        let type, id: Int?
        let country: String?
        let sunrise, sunset: Int?
    }
    
    struct Weather: Codable {
        let id: Int?
        let main, weatherDescription, icon: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case main
            case weatherDescription = "description"
            case icon
        }
    }
    
    struct Wind: Codable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }
}
