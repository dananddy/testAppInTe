//
//  TACellViewModel.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation
import UIKit

class TACellViewModel {
    let cityName: String
    let image: UIImage?
    
    init(cityName: String, image: UIImage?) {
        self.cityName = cityName
        self.image = image
    }
}
