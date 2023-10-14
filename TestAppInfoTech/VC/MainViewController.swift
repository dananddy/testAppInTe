//
//  MainViewController.swift
//  TestAppInfoTech
//
//  Created by busido on 05.10.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    //we will navigate to detail screen with given city model
    var openCityDetails: ((TACityModel) -> Void)?

    private let headerView = UIView()
    private var headerHeightConstraint: NSLayoutConstraint?
    private let containerView = UIView()
    private let tableView = UITableView()
    private let serachController = UISearchController(searchResultsController: nil)
    
    private let viewModel: TAMainVCViewModel
    
    init(viewModel: TAMainVCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = UIView()
        title = "Cities"
        view.backgroundColor = .systemGray
        
        viewModel.delegate = self
        
        setupHeader()
        setupContainer()
        setupTable()
        setupSearchController()
    }
    
    private func setupHeader() {
        view.addSubview(headerView)
        let label = UILabel()
        label.text = "Andriichuk TestApp \nfor InfoTech"
        label.numberOfLines = 2
        
        headerView.addSubview(label)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(lessThanOrEqualToConstant: 150)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        headerHeightConstraint?.isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(lessThanOrEqualToConstant: 110)
        ])
    }
    
    private func setupContainer() {
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTable() {
        tableView.register(TATableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110
        
        containerView.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupSearchController() {
        self.serachController.obscuresBackgroundDuringPresentation = false
        self.serachController.searchResultsUpdater = self
        self.serachController.searchBar.placeholder = "Search"
        
        self.navigationItem.searchController = serachController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func toggleHeaderVisibility(to hidden: Bool) {
        headerHeightConstraint?.constant = hidden ? 30 : 150
        headerView.subviews.forEach({ $0.isHidden = hidden})
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    var cities: [TACityModel] = []
}

extension MainViewController: MainViewModelDelegate {
    func citiesFiltered(_ filteredCities: [TACityModel]) {
        cities = filteredCities
        reloadTableView()
    }
    
    func dataHasUpdated() {
        cities = viewModel.cities
        reloadTableView()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TATableViewCell
        let city = cities[indexPath.row]
        let cellModel = TACellViewModel(cityName: city.name,
                                        image: (indexPath.row % 2 == 0 ? viewModel.image1 : viewModel.image3))
        cell.prepareCell(with: cellModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openCityDetails?(cities[indexPath.row])
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text ?? "").isEmpty {
            toggleHeaderVisibility(to: false)
        } else {
            toggleHeaderVisibility(to: true)
        }
        viewModel.filterCities(for: searchController.searchBar.text ?? "")
    }
}
