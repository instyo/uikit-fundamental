//
//  TextFieldTutorialViewController.swift
//  UIKitTutorial
//
//  Created by ikhwan on 06/12/25.
//

import UIKit

class TextFieldTutorialViewController: UIViewController {
    
    enum TextFieldType: Int {
        case email = 0
        case password = 1
    }

    private var emailField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.returnKeyType = .next
        tf.tag = TextFieldType.email.rawValue
        return tf
    }()
    
    private lazy var passwordField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter Password"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.returnKeyType = .done
        tf.textContentType = .password
        tf.isSecureTextEntry = true
        tf.tag = TextFieldType.password.rawValue
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        tf.rightView = button
        tf.rightViewMode = .always
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        emailField.delegate = self
        passwordField.delegate = self
        
        emailField.addTarget(self, action: #selector(onEmailChanged), for: .editingChanged)
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        
        view.backgroundColor = .white
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
    }
    
    @objc func onEmailChanged(_ sender: UITextField) {
        print("DEBUG : Email is \(String(describing: sender.text))")
    }
    
    @objc func onPasswordChanged(_ sender: UITextField) {
        print("DEBUG : Password is \(String(describing: sender.text))")
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordField.isSecureTextEntry.toggle()
    }
}

extension TextFieldTutorialViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let fieldType = TextFieldType(rawValue: textField.tag) else { return false }
        
        switch fieldType {
        case .email:
            passwordField.becomeFirstResponder()
        case .password:
            passwordField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let fieldType = TextFieldType(rawValue: textField.tag) else { return }
        
        switch fieldType {
        case .email:
            print("DEBUG : Begin Editing Email")
        case .password:
            print("DEBUG : Begin Editing Password")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let fieldType = TextFieldType(rawValue: textField.tag) else { return }

        switch fieldType {
        case .email:
            print("DEBUG : End Editing Email")
        case .password:
            print("DEBUG : End Editing Password")
        }
    }
}

#Preview {
    TextFieldTutorialViewController()
}
