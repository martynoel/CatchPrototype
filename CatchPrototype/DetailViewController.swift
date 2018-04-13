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
    nameTextField.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
        
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
        
        view.addSubview(imageView)
        view.addSubview(nameStackView)
        view.addSubview(updateTimeLastWornButton)
        view.addSubview(changePhotoButton)
        view.addSubview(cancelButton)
        
        setUpImageView()
        setUpNameStackView()
        setUpUpdateTimeLastWornButton()
        setUpChangePhotoButton()
        setUpCancelButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
    }
    
    func setUpImageView() {
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 85).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    func setUpNameStackView() {
        
        nameStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        nameStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
    }
    
    func setUpUpdateTimeLastWornButton() {
        
        updateTimeLastWornButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateTimeLastWornButton.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 20).isActive = true
        updateTimeLastWornButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        updateTimeLastWornButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
    }
    
    func setUpChangePhotoButton() {
        
        changePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changePhotoButton.topAnchor.constraint(equalTo: updateTimeLastWornButton.bottomAnchor, constant: 15).isActive = true
        changePhotoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changePhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
    }
    
    func setUpCancelButton() {
        
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: 10).isActive = true
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

