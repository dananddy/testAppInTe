//
//  CityDetailsVC.swift
//  TestAppInfoTech
//
//  Created by busido on 14.10.2023.
//

import UIKit
import MapKit

class CityDetailsVC: UIViewController {
    
    private let cityModel: TACityModel
    private let weatherAPIClient: TAOpenWeatherAPIClient
    private var viewModel: TACityDetailsViewModel?
    
    private var header = UIStackView()
    private var cityMap = MKMapView()
    
    private var scrollView = UIScrollView()
    private var body = UIView()
    private var cityName = UILabel()
    private var cityDescription = UILabel()
    private var weatherDetailsView = WeatherDetailsView()

    private var errorPresent: (isPresent: Bool, errorDesc: String?) = (false, nil)
    
    init(cityModel: TACityModel) {
        self.cityModel = cityModel
        self.weatherAPIClient = TAOpenWeatherAPIClient(settings: AppService.shared.weatherAPISettings)
        super.init(nibName: nil, bundle: nil)
        
        do {
            try fetchWeatherData(for: cityModel)
        } catch {
            errorPresent = (true, (error as? NetworkError)?.description)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupBody()
    }
    
    private func fetchWeatherData(for model: ITAWeatherCity) throws {
        self.weatherAPIClient.delegate = self
        Task {
            try await weatherAPIClient.fetchWeatherData(for: model)
        }
    }
    
    private func setupHeader() {
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height * 1/3),
            header.widthAnchor.constraint(equalTo: view.widthAnchor),
            header.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
        header.addArrangedSubview(cityMap)
    }
    
    private func setupBody() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(body)
        body.backgroundColor = .systemCyan
        body.layer.cornerRadius = 15
        body.clipsToBounds = true
        scrollView.delegate = self
        body.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            body.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            body.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: view.frame.height * (1/3)),
            body.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            body.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            body.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            body.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        setupTitle()
        setupDescription()
        
        setupWeatherDetails()
    }
    
    private func setupTitle() {
        body.addSubview(cityName)
        cityName.text = cityModel.name
        cityName.textAlignment = .center
        cityName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: body.topAnchor, constant: 15),
            cityName.centerXAnchor.constraint(equalTo: body.centerXAnchor),
            cityName.widthAnchor.constraint(equalTo: body.widthAnchor),
            cityName.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupDescription() {
        body.addSubview(cityDescription)
        
        cityDescription.text = errorPresent.isPresent ? errorPresent.errorDesc : "Loading..."
        
        cityDescription.numberOfLines = 0
        cityDescription.textAlignment = .center
        cityDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityDescription.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 15),
            cityDescription.centerXAnchor.constraint(equalTo: body.centerXAnchor),
            cityDescription.widthAnchor.constraint(equalTo: body.widthAnchor),
            cityDescription.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupWeatherDetails() {
        body.addSubview(weatherDetailsView)
        weatherDetailsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherDetailsView.topAnchor.constraint(equalTo: cityDescription.bottomAnchor),
            weatherDetailsView.centerXAnchor.constraint(equalTo: body.centerXAnchor),
            weatherDetailsView.widthAnchor.constraint(equalTo: body.widthAnchor),
            weatherDetailsView.heightAnchor.constraint(equalToConstant: view.frame.height * 1/3)
        ])
    }
    
    private func reloadData() {
        DispatchQueue.main.sync {
            cityDescription.text = viewModel?.description
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: viewModel!.lat, longitude: viewModel!.lon),
                span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
            cityMap.setRegion(region, animated: true)
            guard let temp = viewModel?.temp,
                  let minTemp = viewModel?.minMaxTemp[MinMaxTempType.min],
                  let maxTemp = viewModel?.minMaxTemp[MinMaxTempType.min],
                  let humidity = viewModel?.humidity,
                  let windSpeed = viewModel?.windSpeed else {
                return
            }
            weatherDetailsView.weatherTempLable.text = "Tempriture:\n\(temp)"
            weatherDetailsView.weatherMinMaxTempLable.text = "Max: \(maxTemp ?? "N/A")/ Min: \(minTemp ?? "N/A")"
            weatherDetailsView.weatherHumidityLable.text = "Humidity:\n\(humidity)"
            weatherDetailsView.windSpeedLable.text = "Winf Speed:\n\(windSpeed)"
        }
    }
    
    private func populateModel(with weatherModel: TAWeatherModel?) -> TACityDetailsViewModel {
        let temp = weatherModel?.main?.temp != nil ? String(weatherModel!.main!.temp!) : nil
        let desc = "City is \(cityModel.name) (\(weatherModel?.name ?? "")) with \(weatherModel?.weather?.first?.weatherDescription ?? "")"
        return TACityDetailsViewModel(name: cityModel.name,
                                      lat: cityModel.coord.lat,
                                      lon: cityModel.coord.lon,
                                      description: desc,
                                      temp: temp,
                                      minMaxTemp: [.max: String(weatherModel?.main?.tempMax ?? 0),
                                                   .min: String(weatherModel?.main?.tempMin ?? 0)],
                                      humidity: String(weatherModel?.main?.humidity ?? 0),
                                      windSpeed: String(weatherModel?.wind?.speed ?? 0))
    }
}

extension CityDetailsVC: TAWeatherAPIDelegate {
    func recived(_ model: TAWeatherModel?) {
        self.viewModel = populateModel(with: model)
        reloadData()
    }
}

extension CityDetailsVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollHeader(with: scrollView.contentOffset.y)
    }
    
    func scrollHeader(with value: CGFloat) {
        header.center = view.center
        header.center.y -= view.frame.height * 0.39
        header.center.y -= value * 0.5
    }
}
