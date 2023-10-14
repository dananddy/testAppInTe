//
//  TAMainVCViewModel.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation
import UIKit

enum TAImageSource: String {
    case image1 = "Temp1.png"
    case image3 = "Temp3.png"
}

protocol MainViewModelDelegate {
    func dataHasUpdated()
    func citiesFiltered(_ filteredCities: [TACityModel])
}

final class TAMainVCViewModel {
    var cities: [TACityModel] = []
    var image1: UIImage?
    var image3: UIImage?
    var inSerachMode: Bool = false
    
    var delegate: MainViewModelDelegate?
    
    init() { 
        AppService.shared.delegate = self
    }
    
    func loadData() {
        AppService.shared.fetchCitiesData()
        try? AppService.shared.fetchImage(.image1)
        try? AppService.shared.fetchImage(.image3)
    }
    
    func filterCities(for substring: String) {
        guard !substring.isEmpty else {
            delegate?.citiesFiltered(cities)
            return
        }
        delegate?.citiesFiltered(cities.filter({ $0.name.lowercased().contains(substring.lowercased())}))
    }
}

extension TAMainVCViewModel: AppServiceDelagate {
    func dataHasLoaded<T>(_ data: T) {
        cities = data as! [TACityModel]
        delegate?.dataHasUpdated()
    }
    
    func imageHasLoaded(_ image: UIImage?, source: TAImageSource) {
        guard let image else {
            return
        }
        switch source {
        case .image1:
            image1 = image
        case .image3:
            image3 = image
        }
        delegate?.dataHasUpdated()
    }
}
