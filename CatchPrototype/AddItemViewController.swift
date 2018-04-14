//
//  AddItemViewController.swift
//  CatchPrototype
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Properties
    
    let itemStore = ItemStore.sharedInstance
    var item: Item!
    var itemImage: UIImage!
    var itemName: String!
    var dateAddedString = "<DATE>"
    var dateLastWornString = "<DATE>"
    
    // Describes states of buttons so that they can change color when pressed
    // 0 = unclicked
    // 1 = clicked
    var changePhotoButtonState = 0
    var cancelButtonState = 0
    
    // MARK: View instantiations by closure
    
    let imageButton: UIButton = {
        
        let itemImage = UIImage(named: "fadedCatchLogo_frame")
        let button = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        button.setImage(itemImage, for: .normal)
        button.setBackgroundImage(nil, for: .normal)
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
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
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    let dateLastWornLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    let changePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        button.setTitle("Change Photo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        
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
    
    // MARK: View lifecycle methods
    
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
        
        // TODO: Get item image too
        itemName = itemName ?? "New Item"
    }
    
    // MARK: View setup methods
    
    func setUpNavBar() {
        self.navigationItem.title = "Add Item"
    
        // Create and set right bar button item to "save"
        let saveItemButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveItem))
        self.navigationItem.rightBarButtonItem = saveItemButton
    }
    
    func setUpImageButton() {
        
        imageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    func setUpNameStackView() {
        
        nameStackView = UIStackView()
        
        nameStackView.axis = .horizontal
        nameStackView.distribution = .fill
        
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
    }
    
    func setUpDateInfo() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let dateAdded = Date()
        let dateLastWorn = Date()
        
        dateAddedString = dateFormatter.string(from: dateAdded)
        dateLastWornString = dateFormatter.string(from: dateLastWorn)
    }
    
    func setUpButtonAndTextFieldStackView() {
        
        setUpDateInfo()
        setUpNameStackView()
        
        buttonsAndTextFieldStackView.addArrangedSubview(nameStackView)
        buttonsAndTextFieldStackView.addArrangedSubview(dateLastWornLabel)
        buttonsAndTextFieldStackView.addArrangedSubview(dateAddedLabel)
        
        dateLastWornLabel.text = "Date Last Worn: \(dateLastWornString)"
        dateAddedLabel.text = "Date Added: \(dateAddedString)"
        buttonsAndTextFieldStackView.addArrangedSubview(changePhotoButton)
        
        buttonsAndTextFieldStackView.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 10).isActive = true
        buttonsAndTextFieldStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        buttonsAndTextFieldStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonsAndTextFieldStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70).isActive = true
    }
    
    func setUpCancelButton() {
        
        cancelButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: buttonsAndTextFieldStackView.bottomAnchor, constant: 10).isActive = true
    }
    
    // MARK: Action methods
    
    @objc func addPhotoButtonPressed() {
        let alertController = UIAlertController(title: "Choose Photo Source", message: nil, preferredStyle: .actionSheet)
        
        // Check if device has camera before presenting camera as an option
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let chooseCameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(chooseCameraAction)
        }
        
        let choosePhotoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            
            let imagePicker = self.imagePicker(for: .photoLibrary)
            
            // Apple wants photo library to be presented in popover, so be it ...
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(choosePhotoLibraryAction)
        
        let chooseCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(chooseCancelAction)
        
        // For iPad: this is where notifications pop up
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    // Dismisses first responder when user taps anywhere on screen
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
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
        
        addPhotoButtonPressed()
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
            
            // Saving an item
            if self.nameTextField.text != nil {
               self.itemName = self.nameTextField.text
            }
            else {
                self.itemName = "New Item"
            }
            
            // TODO: This line is where the user entered info is saved into data model
            self.item = self.itemStore.createItem(called: self.itemName, with: self.itemImage)
            
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (clickCancel) in
            
            self.navigationController?.popViewController(animated: true)
        }
        
        saveAlert.addAction(saveAction)
        saveAlert.addAction(cancelAction)
        
        self.present(saveAlert, animated: true, completion: nil)
    }
    
    // MARK: Delegate methods
    
    // Text field delegate
    
    // Dismisses first responder when user taps Return key on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // Image picker delegate
    
    // Selects source of image picker
    func imagePicker(for sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        return imagePicker
    }
    
    // Called after photo has been selected
    // Adds photo to image view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get image & put on image button
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        itemImage = image
        
        // Resize images properly
        let resizedImage = resizeImage(image: image)
        itemImage = resizedImage
        
        imageButton.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        imageButton.setImage(resizedImage, for: .normal)
        imageButton.setBackgroundImage(nil, for: .normal)
        
        // Dismiss image picker controller
        dismiss(animated: true, completion: nil)
        
        
    }
    
    // MARK: Helper methods
    
    // Helper method to resize user-picked image to fit image button
    // Resizes to 500px x 500px
    func resizeImage(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 500, height: 500))
        image.draw(in: CGRect(x: 0, y: 0, width: 500, height: 500))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}
