//
//  ButtonTutorialViewController.swift
//  UIKitTutorial
//
//  Created by ikhwan on 06/12/25.
//

import UIKit

class ButtonTutorialViewController: UIViewController {
    
    // `lazy` is required because this closure uses `self` (for addTarget).
    // The property will be created only when first accessed.
    private lazy var showNameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show name", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onShowNameTapped), for: .touchUpInside)
        return button
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "My name is Ikhwan"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(showNameButton)
        showNameButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        showNameButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        showNameButton.backgroundColor = .systemBlue
        showNameButton.layer.cornerRadius = 10
        showNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showNameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: showNameButton.bottomAnchor, constant: 16).isActive = true
    }
    
    @objc func onShowNameTapped() {
        nameLabel.isHidden.toggle()
        let title = nameLabel.isHidden ? "Show name": "Hide name"
        showNameButton.setTitle(title, for: .normal)
    }
}

#Preview {
    ButtonTutorialViewController()
}
