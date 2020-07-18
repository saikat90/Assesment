//
//  CountryInfoTableViewCell.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit

class CountryInfoTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        return createLabelWith(font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                               numberOfLines: 1)
    }()
    
    private lazy var descriptionLabel: UILabel = {
        return createLabelWith(font: UIFont.systemFont(ofSize: 14))
    }()
    
    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    lazy var imageDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        return stackView
    }()
    
    var isLandscape: Bool {
        return UIScreen.main.bounds.width > UIScreen.main.bounds.height
    }
    
    func setUpWith(_ cellModel: CountryInfoCellViewModel) {
        titleLabel.text = cellModel.title
        titleLabel.textAlignment = .center
        descriptionLabel.text = cellModel.description
        infoImageView.image = UIImage(named: "placeholder")
        if let imageData = cellModel.imageData {
            infoImageView.image = UIImage(data: imageData)
        }
        imageDescriptionStackView.addArrangedSubview(titleLabel)
        imageDescriptionStackView.addArrangedSubview(infoImageView)
        containerStackView.addArrangedSubview(imageDescriptionStackView)
        containerStackView.addArrangedSubview(descriptionLabel)
        containerStackView.axis = isLandscape ? .horizontal : .vertical
    }
    
    private func createLabelWith(font: UIFont,
                                 numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = font
        label.numberOfLines = numberOfLines
        return label
    }
}
