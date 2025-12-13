//
//  ViewController.swift
//  Loca
//
//  Created by Irina Gubina on 17.09.2025.
//

import UIKit

class CityViewController: UIViewController {
    
    //MARK: - Mock
    
    var cities: [City] = [City(name: "Danang", image: UIImage(named: "Danang") ?? UIImage(named: "newCityPlaceholder")!),
                          City(name: "Bangkok", image: UIImage(named: "Bangkok") ?? UIImage(named: "newCityPlaceholder")!),
                          City(name: "Almaty", image: UIImage(named: "Almaty") ?? UIImage(named: "newCityPlaceholder")!),
                          City(name: "Xue", image: UIImage(named: "Xue") ?? UIImage(named: "newCityPlaceholder")!),
                          City(name: "Danang", image: UIImage(named: "Danang") ?? UIImage(named: "newCityPlaceholder")!),
                          City(name: "Bangkok", image: UIImage(named: "Bangkok") ?? UIImage(named: "newCityPlaceholder")!),
                          City(name: "Almaty", image: UIImage(named: "Almaty") ?? UIImage(named: "newCityPlaceholder")!),
                          City(name: "Xue", image: UIImage(named: "Xue") ?? UIImage(named: "newCityPlaceholder")!)
    ]
    var cityName = ["Danang", "Bangkok", "Almaty", "Xue", "Bangkok", "Almaty", "Xue", "Bangkok", "Almaty", "Xue"]
    var imageCity = ["Danang", "Bangkok", "Almaty", "Xue", "Bangkok", "Almaty", "Xue", "Bangkok", "Almaty", "Xue"]
    
    private var addCityButton: UIButton!
    
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
        layout.minimumLineSpacing = 35
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
    
    //    lazy var addCityButton: UIButton = {
    //        let button = UIButton()
    //        button.layer.cornerRadius = 12
    //        button.backgroundColor = .orangeL
    //        button.setTitle("+ Добавить город", for: .normal)
    //        button.setTitleColor(.whiteL, for: .normal)
    //        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    //        button.contentHorizontalAlignment = .center
    //        button.contentVerticalAlignment = .center
    //        button.addTarget(self, action: #selector(addCityButtonTapped), for: .touchUpInside)
    //
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //
    //        return button
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    
    private func updateUI() {
        if cities.isEmpty {
            placeholderStack.isHidden = false
            collectionView.isHidden = true
        } else {
            placeholderStack.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }
    
    private func setupBarItem() {
        
        guard let addCityButtonImage = UIImage(named: "plusButton") else {
            assertionFailure("Failed to load city adding image")
            return
        }
        
        addCityButton = UIButton.systemButton(with: addCityButtonImage,
                                              target: self,
                                              action: #selector(addCityButtonTapped))
        addCityButton.tintColor = .blackL
        addCityButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addCityButton)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addCityButton)
    }
    
    
    private func showPlaceholder() {
        
    }
    
    private func setupUI() {
        configureView()
        addSubviews()
        setupConstraints()
        setupBarItem()
    }
    
    private func configureView() {
        view.backgroundColor = .beigeL
    }
    
    private func addSubviews() {
        [cityLabel, placeholderStack, collectionView].forEach{
            view.addSubview($0)}
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // City Label
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            //        //Add City Button
            //        addCityButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            //        addCityButton.heightAnchor.constraint(equalToConstant: 45),
            //        addCityButton.widthAnchor.constraint(equalToConstant: 200),
            //        addCityButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        
    }
    
    //TODO: - добавить город (переход на новый экран)
    @objc private func addCityButtonTapped(_ sender: UIButton) {
        let addNewCityVC = AddNewCityViewController()
        addNewCityVC.delegate = self
        
        let addNewCityNC = UINavigationController(rootViewController: addNewCityVC)
        present(addNewCityNC, animated: true)
    }
}


extension CityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Количество элементов: \(cities.count)")
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionViewCell", for: indexPath) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let city = cities[indexPath.item]
        
        cell.imageOfCity.image = city.image
        cell.labelOfCity.text = city.name
        
        return cell
    }
    
    
}

extension CityViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            return self?.createContextMenu(for: indexPath)
        }
    }
    
    private func createContextMenu(for indexPath: IndexPath) -> UIMenu {
        let city = cities[indexPath.item]
        
        let editAction = UIAction(
            title: "Редактировать ") { [weak self] _ in
                self?.editCity(city, at: indexPath)}
        let deleteAction = UIAction(
            title: "Удалить", attributes: .destructive) { [weak self] _ in
                self?.confirmDeleteCity(city, at: indexPath)}
        return UIMenu(children: [editAction, deleteAction])
        
    }
    
    private func editCity(_ city: City, at indexPath: IndexPath) {
        let addNewCityVC = AddNewCityViewController()
        addNewCityVC.delegate = self
        addNewCityVC.editingCity = city
        addNewCityVC.editingIndexPath = indexPath
        
        let addNewCityNC = UINavigationController(rootViewController: addNewCityVC)
        present(addNewCityNC, animated: true)
    }
    
    private func confirmDeleteCity(_ city: City, at indexPath: IndexPath) {
        let alert = UIAlertController(
            title: nil,
            message: "Вы точно хотите удалить город?",
            preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(
            title: "Удалить",
            style: .destructive
        ){ [weak self] _ in
            guard let self = self else { return }
            self.deleteCity(city, at: indexPath)
        }
        
        let cancelAction = UIAlertAction(
            title: "Отмена",
            style: .cancel
        )
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func deleteCity(_ city: City, at indexPath: IndexPath) {
        guard indexPath.item < cities.count else { return }
        cities.remove(at: indexPath.item)
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [indexPath])
        }
    }
}

extension CityViewController: CreateCityControllerDelegate {
    func didCreateCity(_ city: City) {
        cities.append(city)
        updateUI()
    }
    func didEditCity(_ city: City, at index: IndexPath) {
        cities[index.item] = city
        collectionView.reloadItems(at: [index])
        }
}

