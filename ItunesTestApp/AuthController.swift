//
//  AuthController.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 14.04.2022.
//

import UIKit

class AuthController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgrounbView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginLable: UILabel = {
        let lable = UILabel()
        lable.text = "LogIn"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let emailTextFild: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter email"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitle("SignUP", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(AuthController.self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitle("SignIN", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(AuthController.self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var textFieldsStackView = UIStackView()
    private var buttonsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setConstarins()
    }
    
    private func setupViews() {
        title = "SignIn"
        view.backgroundColor = .white
        
        textFieldsStackView = UIStackView(arrangedSubviews: [emailTextFild, passwordTextField],
                                          axis: .vertical,
                                          spacing: 10,
                                          distribution: .fillProportionally)

        buttonsStackView = UIStackView(arrangedSubviews: [signUpButton, signInButton],
                                          axis: .horizontal,
                                          spacing: 10,
                                          distribution: .fillEqually)
        
        view.addSubview(scrollView)
        view.addSubview(backgrounbView)
        backgrounbView.addSubview(textFieldsStackView)
        backgrounbView.addSubview(loginLable)
        backgrounbView.addSubview(buttonsStackView)
    }
    
    private func setupDelegate() {
        emailTextFild.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc private func signUpButtonTapped(){
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }
    
    @objc private func signInButtonTapped() {
        let navVC = UINavigationController(rootViewController: AlbumsViewController())
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }

}


//MARK: - UITextFieldDelegate

extension AuthController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextFild.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

//MARK: - Set Constarins

extension AuthController {
    
    private func setConstarins() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            backgrounbView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgrounbView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgrounbView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            backgrounbView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textFieldsStackView.centerXAnchor.constraint(equalTo: backgrounbView.centerXAnchor),
            textFieldsStackView.centerYAnchor.constraint(equalTo: backgrounbView.centerYAnchor),
            textFieldsStackView.leadingAnchor.constraint(equalTo: backgrounbView.leadingAnchor, constant: 20),
            textFieldsStackView.trailingAnchor.constraint(equalTo: backgrounbView.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            loginLable.centerXAnchor.constraint(equalTo: backgrounbView.centerXAnchor),
            loginLable.bottomAnchor.constraint(equalTo: textFieldsStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: backgrounbView.leadingAnchor, constant: 20),
            buttonsStackView.topAnchor.constraint(equalTo: backgrounbView.bottomAnchor, constant: 30),
            buttonsStackView.trailingAnchor.constraint(equalTo: backgrounbView.trailingAnchor, constant: -20),
        ])
    }
}
