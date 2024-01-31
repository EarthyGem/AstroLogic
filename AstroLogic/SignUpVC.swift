//
//  SignUpVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/29/24.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import UIKit

class SignUpViewController: UIViewController {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Set background color
        
        setupUI()
    }
    
    func setupUI() {
        // Email TextField Configuration
        emailTextField.placeholder = "Enter email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        // Password TextField Configuration
        passwordTextField.placeholder = "Enter password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        // Confirm Password TextField Configuration
        confirmPasswordTextField.placeholder = "Confirm password"
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confirmPasswordTextField)
        
        // Sign Up Button Configuration
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .blue
        signUpButton.layer.cornerRadius = 5
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(signUpUser), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        // Auto Layout Constraints
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func signUpUser() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            print("Please fill in all fields")
            return
        }
        
        // Check if the passwords match
        guard password == confirmPassword else {
            print("Passwords do not match")
            return
        }
 
        // Firebase sign up
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                // Handle the error, perhaps show an alert to the user
                print("Error creating user: \(error.localizedDescription)")
            } else {
                // Navigate to your main app screen or do other setup
                DispatchQueue.main.async {
                    if let navigationController = self?.navigationController {
                        let mainViewController = ViewController() // Initialize your main view controller here
                        navigationController.pushViewController(mainViewController, animated: true)
                    }
                }
            }
        }
    }
    
}
