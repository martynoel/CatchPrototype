//
//  ItemDetailViewController.swift
//  CatchPrototype
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var item: Item! // holds instance of item
    
    // Describes states of buttons so that they can change color when pressed
    // 0 = unclicked
    // 1 = clicked
    var updateDateLastWornButtonState = 0
    var changePhotoButtonState = 0
    var cancelButtonState = 0
    
    let imageButton: UIButton = {
        
        let itemImage = UIImage(named: "fadedCatchLogo_frame")
        let button = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        button.setImage(itemImage, for: .normal)
        
        button.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        
        button.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Name:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let nameTextField: UITextField = {
        
        let textField = UITextField()
        
        textField.placeholder = "What's your item called?"
    textField.setContentHuggingPriority(UILayoutPriority(rawValue: 10), for: .horizontal)
        
        return textField
    }()
    
    let nameStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    let dateLastWornLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    let dateAddedLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Date Added:"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    let updateDateLastWornButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        button.setTitle("Update Date Last Worn", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(updateDateLastWornButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    let changePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        button.setTitle("Change Photo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    let buttonsAndTextFieldStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    let cancelButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Your Item"
    
        nameTextField.text = item.name
        dateAddedLabel.text = "Date Added: \(item.dateAddedString)"
        dateLastWornLabel.text = "Date Last Worn: \(item.dateLastWornString)"
        
        view.addSubview(imageButton)
        view.addSubview(nameStackView)
        view.addSubview(buttonsAndTextFieldStackView)
        view.addSubview(cancelButton)
        
        setUpImageButton()
        setUpNameStackView()
        setUpButtonAndTextFieldStackView()
        setUpCancelButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        view.backgroundColor = .white
        
//        nameTextField.text = item.name
//        dateAddedLabel.text = "Date Added: \(item.dateAddedString)"
//        dateLastWornLabel.text = "Date Last Worn: \(item.dateLastWornString)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        // Save changes to item (superficially for now)
        item.name = nameTextField.text ?? "No item name"
    }
    
    func setUpImageButton() {
        
        imageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //        imageButton.heightAnchor.constraint(equalToConstant: 350).isActive = true
        imageButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20).isActive = true
    }
    
    func setUpNameStackView() {
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        
        nameStackView.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 30).isActive = true
        nameStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
    }
    
    func setUpButtonAndTextFieldStackView() {
        buttonsAndTextFieldStackView.addArrangedSubview(dateLastWornLabel)
        buttonsAndTextFieldStackView.addArrangedSubview(dateAddedLabel)
        buttonsAndTextFieldStackView.addArrangedSubview(updateDateLastWornButton)
        buttonsAndTextFieldStackView.addArrangedSubview(changePhotoButton)
        
        buttonsAndTextFieldStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 20).isActive = true
        buttonsAndTextFieldStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonsAndTextFieldStackView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        buttonsAndTextFieldStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70).isActive = true
    }
    
    func setUpCancelButton() {
        
        cancelButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: buttonsAndTextFieldStackView.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func updateDateLastWornButtonPressed() {
        
        // Update date
        item.updateDateLastWorn()
        dateLastWornLabel.text = "Date Last Worn: \(item.dateLastWornString)"
        
        // Update visual indicators
        if updateDateLastWornButtonState == 0 {
            updateDateLastWornButtonState = 1
            updateDateLastWornButton.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 102/255, alpha: 1)
        }
        else {
            updateDateLastWornButtonState = 0
            updateDateLastWornButton.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        }
    }
    
    @objc func changePhotoButtonPressed() {
        
        if changePhotoButtonState == 0 {
            changePhotoButtonState = 1
            changePhotoButton.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 102/255, alpha: 1)
        }
        else {
            changePhotoButtonState = 0
            changePhotoButton.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        }
    }
    
    @objc func cancelButtonPressed() {
        
        if cancelButtonState == 0 {
            cancelButtonState = 1
            cancelButton.setTitleColor(UIColor(red: 255/255, green: 127/255, blue: 102/255, alpha: 1), for: .normal)
        }
        else {
            cancelButtonState = 0
            cancelButton.setTitleColor(UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1), for: .normal)
        }
    }
}
