//
//  AppCoordinator.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation
import UIKit

class AppCoordinator {
    var router: UINavigationController
    
    init(router : UINavigationController) {
        self.router = router
    }
    
    func start() {
        showMainFlow()
    }
    
    private func showMainFlow() {
        let model = TAMainVCViewModel()
        let vc = MainViewController(viewModel: model)
        model.loadData()
        vc.openCityDetails = { [weak self] cityModel in
            self?.openCityDetails(for: cityModel)
        }
        router.pushViewController(vc, animated: true)
    }
    
    private func openCityDetails(for city: TACityModel) {
        let vc = CityDetailsVC(cityModel: city)
        router.pushViewController(vc, animated: true)
    }
}

