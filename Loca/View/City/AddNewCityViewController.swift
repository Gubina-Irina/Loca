//
//  AddNewCityViewController.swift
//  Loca
//
//  Created by Irina Gubina on 01.10.2025.
//

import UIKit

protocol CreateCityControllerDelegate: AnyObject {
    func didCreateCity(_ city: City)
}

class AddNewCityViewController: UIViewController {
    weak var createDelegate: CreateCityControllerDelegate?
    
    
    //MARK: - UI Elements
    
    lazy var cityImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGrayL
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var nameCityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите город"
        textField.tintColor = .grayL
        textField.textColor = .blackL
        textField.backgroundColor = .lightGrayL
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.layer.cornerRadius = 16
        textField.leftView = UIView(frame: CGRect (x: 16, y: 0, width: 17, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.delegate = self
        textField.returnKeyType = .done
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .grayL
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.whiteL, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orangeL.cgColor
        button.backgroundColor = .clear
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.orangeL, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if cityImageView.image == nil {
            cityImageView.image = .addCityPlaceholder
        }
        
        setupUI()
        cityImageViewTapped()
        updateCreateButtonState()
    }
    
    private func cityImageViewTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        cityImageView.isUserInteractionEnabled = true
        cityImageView.addGestureRecognizer(tapGesture)

    }
    
    private func setupUI() {
        configureView()
        addSubviews()
        setupConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = .beigeL
        title = "Новый город"
    }
    
    private func addSubviews() {
        [cityImageView, nameCityTextField, createButton, cancelButton].forEach {
            view.addSubview($0)}
    }
    
    private func setupConstraints() {
        //City ImageView
        NSLayoutConstraint.activate([
            cityImageView.heightAnchor.constraint(equalToConstant: 280),
            cityImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cityImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cityImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17),
            
        //Name City TextField
            nameCityTextField.heightAnchor.constraint(equalToConstant: 50),
            nameCityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameCityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameCityTextField.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 20),
            
        //Cancel Button
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.widthAnchor.constraint(equalToConstant: 166),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        //Create Button
            createButton.heightAnchor.constraint(equalToConstant: 60),
            createButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 8),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        ])
    }
    
    func updateCreateButtonState() {
        let isNameTextField = !(nameCityTextField.text?.isEmpty ?? true)
        createButton.isEnabled = isNameTextField
        createButton.backgroundColor = isNameTextField ? .blackL : .grayL
    }
    
    
    @objc func textFieldChanged() {
        updateCreateButtonState()
    }
    
    @objc func createButtonTapped() {
        guard let name = nameCityTextField.text, !name.isEmpty,
              let image = cityImageView.image else { return }
        
        let newCity = City(name: name,
                           image: image)
        
        createDelegate?.didCreateCity(newCity)
        dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func selectImage() {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.cityImageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.cityImageView.transform = .identity
            }
        }
        
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera",
                                   style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        
        let photo = UIAlertAction(title: "Photo",
                                  style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
       }
        
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
}


extension AddNewCityViewController: UITextFieldDelegate {
    //скрываем клавиатуру по нажатию Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//работа с изображением

extension AddNewCityViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            imagePicker.delegate = self
            present(imagePicker, animated: true)
        } else {
            print("Камера недоступна на этом устройстве")
            return
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        cityImageView.image = info[.editedImage] as? UIImage
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        dismiss(animated: true)
    }
}
