//
//  ViewController.swift
//  Loca
//
//  Created by Irina Gubina on 17.09.2025.
//

import UIKit

class CityViewController: UIViewController {
    
    //MARK: - Mock
    var cityName = ["Danang", "Bangkok", "Almaty", "Xue", "Bangkok", "Almaty", "Xue", "Bangkok", "Almaty", "Xue"]
    var imageCity = ["Danang", "Bangkok", "Almaty", "Xue", "Bangkok", "Almaty", "Xue", "Bangkok", "Almaty", "Xue"]
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .blackL
        label.text = "Города"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 165)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 18, right: 16)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var placeholderCityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .newCityPlaceholder
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return imageView
    }()
    
    lazy var placeholderCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textColor = .blackL
        label.textAlignment = .center
        label.text = "Здесь пока пусто"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var placeholderExplainEmptyCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = .blackL
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Добавьте свой первый город, чтобы\nначать коллекционировать места."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var placeholderStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeholderCityImageView, placeholderCityLabel, placeholderExplainEmptyCityLabel])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var addCityButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .orangeL
        button.setTitle("+ Добавить город", for: .normal)
        button.setTitleColor(.whiteL, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(addCityButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    
    private func updateUI() {
        if cityName.isEmpty && imageCity.isEmpty {
            placeholderStack.isHidden = false
            collectionView.isHidden = true
        } else {
            placeholderStack.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }
    
    private func showPlaceholder() {
        
    }
    
    private func setupUI() {
        configureView()
        addSubviews()
        setupConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = .beigeL
    }
    
    private func addSubviews() {
        [cityLabel, placeholderStack, collectionView, addCityButton].forEach{
            view.addSubview($0)}
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        // City Label
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        
        //Placeholder City ImageView
        placeholderCityImageView.heightAnchor.constraint(equalToConstant: 165),
        placeholderCityImageView.widthAnchor.constraint(equalToConstant: 160),
        
        //Placeholder StackView
        placeholderStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        placeholderStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 170),
        
        // CollectionView
        collectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30),
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        //Add City Button
        addCityButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        addCityButton.heightAnchor.constraint(equalToConstant: 45),
        addCityButton.widthAnchor.constraint(equalToConstant: 200),
        addCityButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        
    }
    
    //TODO: - добавить город (переход на новый экран)
    @objc private func addCityButtonTapped(_ sender: UIButton) {
        
    }


}


extension CityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Количество элементов: \(cityName.count)")
        return cityName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionViewCell", for: indexPath) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageName = imageCity[indexPath.item]
        let nameName = cityName[indexPath.item]
        let image = UIImage(named: imageName)
        print("Загружаем картинку \(imageName): \(image != nil)")
        
        cell.imageOfCity.image = image
        cell.labelOfCity.text = nameName
        
        return cell
    }
    
    
}

extension CityViewController: UICollectionViewDelegate {
    
}

