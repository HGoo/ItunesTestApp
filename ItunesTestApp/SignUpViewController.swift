//
//  SignUpViewController.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 14.04.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
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
        lable.text = "Registration"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First Name"
        return textField
    }()
    
    private let firstNameValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Required field"
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Second Name"
        return textField
    }()
    
    private let secondNameValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Required field"
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let ageValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Required field"
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Required field"
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let emailNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-mail"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let emailValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Required field"
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let passwordValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Required field"
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitle("SignUP", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var elementsStackView = UIStackView()
    private var datePicekr = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setConstraints()
        setDatePicker()
    }
    
    private func setupViews() {
        title = "SignUP"
        
        elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                           firstNameValidLable,
                                                           secondNameTextField,
                                                           secondNameValidLable,
                                                           datePicekr,
                                                           ageValidLable,
                                                           phoneNumberTextField,
                                                           phoneValidLable,
                                                           emailNumberTextField,
                                                           emailValidLable,
                                                           passwordTextField,
                                                           phoneValidLable],
                                        axis: .vertical,
                                        spacing: 10,
                                        distribution: .fillProportionally)
        view.addSubview(scrollView)
        view.addSubview(backgrounbView)
        backgrounbView.addSubview(elementsStackView)
        backgrounbView.addSubview(loginLable)
        backgrounbView.addSubview(signUpButton)
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailNumberTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setDatePicker() {
        datePicekr.datePickerMode = .date
        datePicekr.backgroundColor = .white
        datePicekr.layer.borderColor = #colorLiteral(red: 0.992223084, green: 1, blue: 0.9489852786, alpha: 1)
        datePicekr.layer.borderWidth = 1
        datePicekr.clipsToBounds = true
        datePicekr.layer.cornerRadius = 6
        datePicekr.tintColor = .black
    }
    
    @objc private func signUpButtonTapped() {
        print("SignUpTap")
    }
}

//MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailNumberTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

//MARK: - Set Constarins

extension SignUpViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            backgrounbView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgrounbView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgrounbView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgrounbView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            elementsStackView.centerXAnchor.constraint(equalTo: backgrounbView.centerXAnchor),
            elementsStackView.centerYAnchor.constraint(equalTo: backgrounbView.centerYAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: backgrounbView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgrounbView.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            loginLable.centerXAnchor.constraint(equalTo: backgrounbView.centerXAnchor),
            loginLable.bottomAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: backgrounbView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 30),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
}
