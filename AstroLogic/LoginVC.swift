//
//  LoginVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/29/24.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Set background color

        setupUI()
    }

    func setupUI() {
        // Email TextField Configuration
        emailTextField.placeholder = "Enter email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)

        // Password TextField Configuration
        passwordTextField.placeholder = "Enter password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)

        // Login Button Configuration
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 5
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        view.addSubview(loginButton)

        // Auto Layout Constraints
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


    
    @objc func loginUser() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Email or password field is empty")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
            } else {
                // Navigate to your main app screen
                DispatchQueue.main.async {
                    if let navigationController = self?.navigationController {
                        let viewController = ViewController() // Initialize your ViewController here
                        navigationController.pushViewController(viewController, animated: true)
                    }
                }
            }
        }
    }
}
