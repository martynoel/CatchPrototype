//
//  ItemDetailViewController.swift
//  CatchPrototype
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let imageView: UIImageView = {
        
        let itemImage = UIImage(named: "fadedCatchLogo_frame")
        let image = UIImageView(image: itemImage!)
        
        image.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let nameStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        let nameLabel = UILabel()
        nameLabel.text = "Name:"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let nameTextField = UITextField()
        nameTextField.placeholder = "What's your item called?"
    nameTextField.setContentHuggingPriority(UILayoutPriority(rawValue: 10), for: .horizontal)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let updateTimeLastWornButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        button.setTitle("Update Date Last Worn", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(updateTimeLastWornButtonPressed), for: .touchUpInside)
        
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
        
        self.navigationItem.title = "Individual Item"
        
        view.addSubview(imageView)
        view.addSubview(nameStackView)
        view.addSubview(buttonsAndTextFieldStackView)
        view.addSubview(cancelButton)
        
        setUpImageView()
        setUpNameStackView()
        setUpButtonAndTextFieldStackView()
        setUpCancelButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
    }
    
    func setUpImageView() {
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    func setUpNameStackView() {
        
        nameStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        nameStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
    }
    
    func setUpButtonAndTextFieldStackView() {
        
buttonsAndTextFieldStackView.addArrangedSubview(updateTimeLastWornButton)
    buttonsAndTextFieldStackView.addArrangedSubview(changePhotoButton)
        
        buttonsAndTextFieldStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 30).isActive = true
        buttonsAndTextFieldStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    buttonsAndTextFieldStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        buttonsAndTextFieldStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -35).isActive = true
    }
    
    func setUpCancelButton() {
        
        cancelButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: buttonsAndTextFieldStackView.bottomAnchor, constant: 15).isActive = true
    }
    
    @objc func updateTimeLastWornButtonPressed() {
        print("Update time last worn button pressed")
    }
    
    @objc func changePhotoButtonPressed() {
        print("Change photo button pressed")
    }
    
    @objc func cancelButtonPressed() {
        print("Cancel button pressed")
    }
}
