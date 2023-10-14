//
//  TATableViewCell.swift
//  TestAppInfoTech
//
//  Created by busido on 13.10.2023.
//

import UIKit

class TATableViewCell: UITableViewCell {

    let container = UIStackView()
    let imageViewContainer = UIImageView()
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell(with model: TACellViewModel) {
        imageViewContainer.image = model.image
        label.text = model.cityName
    }
    
    private func setupCell() {
        addSubview(container)
        container.addArrangedSubview(imageViewContainer)
        container.addArrangedSubview(label)
        
        setupContainer()
        setupImageView()
        setupLabel()
    }
    
    private func setupContainer() {
        container.spacing = 10
        container.alignment = .leading
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    private func setupImageView() {
        imageViewContainer.layer.cornerRadius = 15
        imageViewContainer.clipsToBounds = true
        
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewContainer.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageViewContainer.widthAnchor.constraint(equalToConstant: 120),
            imageViewContainer.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}
