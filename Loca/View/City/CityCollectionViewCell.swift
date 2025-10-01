//
//  CityCollectionViewCell.swift
//  Loca
//
//  Created by Irina Gubina on 30.09.2025.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CityCollectionViewCell"

    //MARK: - UI Elements
    
    lazy var imageOfCity: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var labelOfCity: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .whiteL
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(imageOfCity)
        imageOfCity.addSubview(labelOfCity)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //Image of city
            imageOfCity.heightAnchor.constraint(equalToConstant: 160),
            imageOfCity.widthAnchor.constraint(equalToConstant: 165),
            imageOfCity.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageOfCity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageOfCity.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            //Label of city
            labelOfCity.leadingAnchor.constraint(equalTo: imageOfCity.leadingAnchor, constant: 8),
            labelOfCity.bottomAnchor.constraint(equalTo: imageOfCity.bottomAnchor, constant: -8),
            labelOfCity.trailingAnchor.constraint(equalTo: imageOfCity.trailingAnchor, constant: -5)
        ])
    }
}
