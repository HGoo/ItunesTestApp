//
//  UserInfoViewController.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 14.04.2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    private let firstNameLabel: UILabel = {
        let lable = UILabel()
        lable.text = "First Name"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let secondNameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Second name"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let ageLable: UILabel = {
        let lable = UILabel()
        lable.text = "Age"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let phoneLable: UILabel = {
        let lable = UILabel()
        lable.text = "Phone"
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
    
    private let emailLable: UILabel = {
        let lable = UILabel()
        lable.text = "Email"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let passwordLable: UILabel = {
        let lable = UILabel()
        lable.text = "Password"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setModel()
    }
    
    private func setupViews() {
        title = "Active User"
        view.backgroundColor = .white
        
        stackView = UIStackView(arrangedSubviews: [firstNameLabel,
                                                  secondNameLable,
                                                  ageLable,
                                                  phoneLable,
                                                  emailLable,
                                                  passwordLable],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .fillProportionally)
        view.addSubview(stackView)
    }
    
    private func  setModel() {
        guard let activeUser = DataBase.shared.activeUser else { return }
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormater.string(from: activeUser.age)
        
        firstNameLabel.text = activeUser.firstName
        secondNameLable.text = activeUser.secondName
        phoneLable.text = activeUser.phone
        emailLable.text = activeUser.email
        passwordLable.text = activeUser.password
        ageLable.text = dateString
    }
}

//MARK: - Set Constarins

extension UserInfoViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

    }
}
