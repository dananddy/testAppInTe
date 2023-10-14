//
//  TAOpenWeatherAPIClinet.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation

protocol ITAWeatherCity {
    var lon: String { get }
    var lat: String { get }
}

protocol TAWeatherAPIDelegate {
    func recived(_ model: TAWeatherModel?)
}

class TAOpenWeatherAPIClient {
    let settings: TAOpenWeatherSettings
    
    var delegate: TAWeatherAPIDelegate?
    
    init(settings: TAOpenWeatherSettings) {
        self.settings = settings
    }
    
    func fetchWeatherData(for model: ITAWeatherCity) async throws {
        let request = buildRequest(model.lat, model.lon, settings.apiKey)
        let weatherData = try await NetworkService.shared.fetchData(url: settings.url, settings.endpoint, request: request)
        let weatherModel = try? JSONDecoder().decode(TAWeatherModel.self, from: weatherData)
        delegate?.recived(weatherModel)
    }
    
    private func buildRequest(_ lat: String, _ lon: String, _ apiKey: String) -> String {
        "lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
    }
}
