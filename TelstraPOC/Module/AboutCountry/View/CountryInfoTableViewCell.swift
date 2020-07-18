//
//  CountryInfoTableViewCell.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit

class CountryInfoTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        return createLabelWith(font: UIFont.systemFont(ofSize: 16, weight: .medium),
                               numberOfLines: 1)
    }()
    
    lazy var descriptionLabel: UILabel = {
        return createLabelWith(font: UIFont.systemFont(ofSize: 14))
    }()
    
    lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoImageView.heightAnchor.constraint(equalToConstant: 100),
            infoImageView.widthAnchor.constraint(equalToConstant: 100),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        return stackView
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpWith(_ cellModel: CountryInfoCellViewModel) {
        titleLabel.text = cellModel.title
        descriptionLabel.text = cellModel.description
        infoImageView.image = UIImage(named: "placeholder")
        if let imageData = cellModel.imageData {
            infoImageView.image = UIImage(data: imageData)
        }
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(infoImageView)
        containerStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func createLabelWith(font: UIFont,
                                 numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = font
        label.numberOfLines = numberOfLines
        return label
    }
}
