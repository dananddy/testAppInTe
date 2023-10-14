//
//  AppService.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation
import UIKit

protocol AppServiceDelagate {
    func dataHasLoaded<T>(_ data: T)
    func imageHasLoaded(_ image: UIImage?, source: TAImageSource)
}

class AppService {
    private static let citiesSourse = "city_list"
    private static var imageURL = "https://infotech.gov.ua"
    
    var weatherAPISettings: TAOpenWeatherSettings {
        TAOpenWeatherSettings(url: "https://api.openweathermap.org",
                              endpoint: "/data/2.5/weather?",
                              apiKey: "390ac19c8a7714ca870709e8bac7688b")
    }
    
    static let shared = AppService()
    
    var delegate: AppServiceDelagate?
    
    func fetchImage(_ source: TAImageSource) throws {
        Task {
            let image = try await fetchExternaImagelData(for: source)
            delegate?.imageHasLoaded(image, source: source)
        }
    }
    
    func fetchExternaImagelData(for source: TAImageSource) async throws -> UIImage? {
        if let cachedImageData = CacheManager.shared.cacheLookup(from: source.rawValue) {
            return UIImage(data: cachedImageData)
        }
        let data = try await NetworkService.shared.fetchData(url: AppService.imageURL, "/storage/img/", request: source.rawValue)
        CacheManager.shared.saveToCahce(data, for: source.rawValue)
        return UIImage(data: data)
    }
    
    func fetchCitiesData() {
        Task {
            let cities: [TACityModel] = await StorageManager.shared.fetchLocalJsonData(from: AppService.citiesSourse) ?? []
            delegate?.dataHasLoaded(cities)
        }
    }
}
