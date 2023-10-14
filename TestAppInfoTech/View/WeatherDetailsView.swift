//
//  WeatherDetailsView.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import Foundation
import UIKit

class WeatherDetailsView: UIView {
    
    private var weatherDetailsContainer = UIView()
    
    private var weatherTempContainer = UIView()
    var weatherTempLable = UILabel()

    private var weatherMinMaxTempContainer = UIView()
    var weatherMinMaxTempLable = UILabel()

    private var weatherHumidityContainer = UIView()
    var weatherHumidityLable = UILabel()

    private var windSpeedContainer = UIView()
    var windSpeedLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWeatherDetails()
        setupTempContainer()
        setupMinMaxTempContainer()
        setupHumidityContainer()
        setupWindSpeedContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWeatherDetails() {
        addSubview(weatherDetailsContainer)
        weatherDetailsContainer.backgroundColor = .systemGray
        weatherDetailsContainer.layer.cornerRadius = 12
        weatherDetailsContainer.clipsToBounds = true
        weatherDetailsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherDetailsContainer.topAnchor.constraint(equalTo: topAnchor),
            weatherDetailsContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherDetailsContainer.widthAnchor.constraint(equalTo: widthAnchor),
            weatherDetailsContainer.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    
    private func setupMinMaxTempContainer() {
        weatherDetailsContainer.addSubview(weatherMinMaxTempContainer)
        weatherMinMaxTempContainer.backgroundColor = .systemYellow
        weatherMinMaxTempContainer.layer.cornerRadius = 15
        weatherMinMaxTempContainer.clipsToBounds = true
        
        weatherMinMaxTempContainer.addSubview(weatherMinMaxTempLable)
        
        weatherMinMaxTempContainer.translatesAutoresizingMaskIntoConstraints = false
        weatherMinMaxTempLable.translatesAutoresizingMaskIntoConstraints = false
        
        weatherMinMaxTempLable.text = "Loading..."
        weatherMinMaxTempLable.numberOfLines = 0
        weatherMinMaxTempLable.textAlignment = .center
        weatherMinMaxTempLable.numberOfLines = 0
                
        NSLayoutConstraint.activate([
            weatherMinMaxTempContainer.topAnchor.constraint(equalTo: weatherDetailsContainer.topAnchor, constant: 20),
            weatherMinMaxTempContainer.trailingAnchor.constraint(equalTo: weatherDetailsContainer.trailingAnchor, constant: -20),
            weatherMinMaxTempContainer.widthAnchor.constraint(equalTo: weatherDetailsContainer.widthAnchor, multiplier: 0.4),
            weatherMinMaxTempContainer.heightAnchor.constraint(equalTo: weatherDetailsContainer.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            weatherMinMaxTempLable.topAnchor.constraint(equalTo: weatherMinMaxTempContainer.topAnchor),
            weatherMinMaxTempLable.leadingAnchor.constraint(equalTo: weatherMinMaxTempContainer.leadingAnchor),
            weatherMinMaxTempLable.trailingAnchor.constraint(equalTo: weatherMinMaxTempContainer.trailingAnchor),
            weatherMinMaxTempLable.bottomAnchor.constraint(equalTo: weatherMinMaxTempContainer.bottomAnchor)
        ])
    }
    
    private func setupHumidityContainer() {
        weatherDetailsContainer.addSubview(weatherHumidityContainer)
        weatherHumidityContainer.backgroundColor = .systemYellow
        weatherHumidityContainer.layer.cornerRadius = 15
        weatherHumidityContainer.clipsToBounds = true
        
        weatherHumidityContainer.addSubview(weatherHumidityLable)
        
        weatherHumidityContainer.translatesAutoresizingMaskIntoConstraints = false
        weatherHumidityLable.translatesAutoresizingMaskIntoConstraints = false
        
        weatherHumidityLable.text = "Loading..."
        weatherHumidityLable.numberOfLines = 0
        weatherHumidityLable.textAlignment = .center
        
        NSLayoutConstraint.activate([
            weatherHumidityContainer.bottomAnchor.constraint(equalTo: weatherDetailsContainer.bottomAnchor, constant: -20),
            weatherHumidityContainer.leadingAnchor.constraint(equalTo: weatherDetailsContainer.leadingAnchor, constant: 20),
            weatherHumidityContainer.widthAnchor.constraint(equalTo: weatherDetailsContainer.widthAnchor, multiplier: 0.4),
            weatherHumidityContainer.heightAnchor.constraint(equalTo: weatherDetailsContainer.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            weatherHumidityLable.topAnchor.constraint(equalTo: weatherHumidityContainer.topAnchor),
            weatherHumidityLable.leadingAnchor.constraint(equalTo: weatherHumidityContainer.leadingAnchor),
            weatherHumidityLable.trailingAnchor.constraint(equalTo: weatherHumidityContainer.trailingAnchor),
            weatherHumidityLable.bottomAnchor.constraint(equalTo: weatherHumidityContainer.bottomAnchor)
        ])
    }
    
    private func setupWindSpeedContainer() {
        weatherDetailsContainer.addSubview(windSpeedContainer)
        windSpeedContainer.backgroundColor = .systemYellow
        windSpeedContainer.layer.cornerRadius = 15
        windSpeedContainer.clipsToBounds = true
        
        windSpeedContainer.addSubview(windSpeedLable)
        
        windSpeedContainer.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLable.translatesAutoresizingMaskIntoConstraints = false
        
        windSpeedLable.text = "Loading..."
        windSpeedLable.numberOfLines = 0
        windSpeedLable.textAlignment = .center
        
        NSLayoutConstraint.activate([
            windSpeedContainer.bottomAnchor.constraint(equalTo: weatherDetailsContainer.bottomAnchor, constant: -20),
            windSpeedContainer.trailingAnchor.constraint(equalTo: weatherDetailsContainer.trailingAnchor, constant: -20),
            windSpeedContainer.widthAnchor.constraint(equalTo: weatherDetailsContainer.widthAnchor, multiplier: 0.4),
            windSpeedContainer.heightAnchor.constraint(equalTo: weatherDetailsContainer.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            windSpeedLable.topAnchor.constraint(equalTo: windSpeedContainer.topAnchor),
            windSpeedLable.leadingAnchor.constraint(equalTo: windSpeedContainer.leadingAnchor),
            windSpeedLable.trailingAnchor.constraint(equalTo: windSpeedContainer.trailingAnchor),
            windSpeedLable.bottomAnchor.constraint(equalTo: windSpeedContainer.bottomAnchor)
        ])
    }
    
    private func setupTempContainer() {
        weatherDetailsContainer.addSubview(weatherTempContainer)
        weatherTempContainer.backgroundColor = .systemYellow
        weatherTempContainer.layer.cornerRadius = 15
        weatherTempContainer.clipsToBounds = true
        
        weatherTempContainer.addSubview(weatherTempLable)
        
        weatherTempContainer.translatesAutoresizingMaskIntoConstraints = false
        weatherTempLable.translatesAutoresizingMaskIntoConstraints = false
        
        weatherTempLable.text = "Loading..."
        weatherTempLable.numberOfLines = 0
        weatherTempLable.numberOfLines = 0
        weatherTempLable.textAlignment = .center
        
        NSLayoutConstraint.activate([
            weatherTempContainer.topAnchor.constraint(equalTo: weatherDetailsContainer.topAnchor, constant: 20),
            weatherTempContainer.leadingAnchor.constraint(equalTo: weatherDetailsContainer.leadingAnchor, constant: 20),
            weatherTempContainer.widthAnchor.constraint(equalTo: weatherDetailsContainer.widthAnchor, multiplier: 0.4),
            weatherTempContainer.heightAnchor.constraint(equalTo: weatherDetailsContainer.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            weatherTempLable.topAnchor.constraint(equalTo: weatherTempContainer.topAnchor),
            weatherTempLable.leadingAnchor.constraint(equalTo: weatherTempContainer.leadingAnchor),
            weatherTempLable.trailingAnchor.constraint(equalTo: weatherTempContainer.trailingAnchor),
            weatherTempLable.bottomAnchor.constraint(equalTo: weatherTempContainer.bottomAnchor)
        ])
    }
}
