//
//  AddItemViewController.swift
//  CatchPrototype
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
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
        
        button.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        
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
    
//    let nameStackView: UIStackView = {
//        let stackView = UIStackView()
//
//        stackView.axis = .horizontal
//        stackView.distribution = .fillProportionally
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        stackView.addArrangedSubview(nameLabel)
//        stackView.addArrangedSubview(nameTextField)
//
//        return stackView
//    }()
    
    var nameStackView = UIStackView()
    
    let buttonsAndTextFieldStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let dateAddedLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Date Added:"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    let dateLastWornLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "// TODO: Date Last Worn:"
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
        
        setUpNavBar()
        
        view.backgroundColor = .white
        nameTextField.delegate = self
        
        view.addSubview(imageButton)
        view.addSubview(buttonsAndTextFieldStackView)
        view.addSubview(cancelButton)
        
        setUpImageButton()
        setUpButtonAndTextFieldStackView()
        setUpCancelButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        // Clear first responder when user presses "back"
        view.endEditing(true)
        
        // TODO: Replace with actual item
        var itemName = nameTextField.text ?? "No item name"
    }
    
    // Dismisses first responder when user taps Return key on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // Dismisses first responder when user taps anywhere on screen
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    func setUpNavBar() {
        self.navigationItem.title = "Add Item"
    
        // Create and set right bar button item to "save"
        let saveItemButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveItem))
        self.navigationItem.rightBarButtonItem = saveItemButton
    }
    
    func setUpImageButton() {
        
        imageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20).isActive = true
    }
    
    func setUpNameStackView() {
        
        nameStackView = UIStackView()
        
        nameStackView.axis = .horizontal
        nameStackView.distribution = .fillProportionally
        
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
    }
    
    func setUpButtonAndTextFieldStackView() {
        
        setUpNameStackView()
        
        buttonsAndTextFieldStackView.addArrangedSubview(nameStackView)
        buttonsAndTextFieldStackView.addArrangedSubview(dateLastWornLabel)
        buttonsAndTextFieldStackView.addArrangedSubview(dateAddedLabel)
        buttonsAndTextFieldStackView.addArrangedSubview(updateDateLastWornButton)
        buttonsAndTextFieldStackView.addArrangedSubview(changePhotoButton)
        
        buttonsAndTextFieldStackView.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 20).isActive = true
        buttonsAndTextFieldStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonsAndTextFieldStackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        buttonsAndTextFieldStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70).isActive = true
    }
    
    func setUpCancelButton() {
        
        cancelButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: buttonsAndTextFieldStackView.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func addPhotoButtonPressed() {
        print("added photo")
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
    
    @objc func updateDateLastWornButtonPressed() {
        
        // Update date
//        item.updateDateLastWorn()
//        dateLastWornLabel.text = "Date Last Worn: \(item.dateLastWornString)"
        
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
    
    @objc func saveItem() {
        
        let saveAlert = UIAlertController(title: "Save Item?", message: "Are you sure you want to save this item? You can always edit it later.", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (saveItem) in
            
            // TODO: Item-saving code here
            print("Item saved")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (clickCancel) in
            
            self.dismiss(animated: true, completion: nil)
        }
        
        saveAlert.addAction(saveAction)
        saveAlert.addAction(cancelAction)
        
        self.present(saveAlert, animated: true, completion: nil)
    }
}
