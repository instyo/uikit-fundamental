//
//  DelegateDesignTutorialViewController.swift
//  UIKitTutorial
//
//  Created by ikhwan on 06/12/25.
//

import UIKit

class DelegateDesignTutorialViewController: UIViewController {
    
    private var actionButtonView = ActionButtonView()
    
    private var textLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        view.addSubview(actionButtonView)
        actionButtonView.layer.shadowColor = UIColor.black.cgColor
        actionButtonView.layer.cornerRadius = 16
        actionButtonView.translatesAutoresizingMaskIntoConstraints = false
        actionButtonView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        actionButtonView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        actionButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionButtonView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        actionButtonView.delegate = self
        
        view.addSubview(textLabel)
        textLabel.text = "Hello, world!"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: actionButtonView.bottomAnchor, constant: 16).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.isHidden = true
    }
}

extension DelegateDesignTutorialViewController: ActionButtonViewDelegate {
    func onTapPrimary() {
        print("DEBUG : on tap primary from VC")
        textLabel.isHidden = false
    }
    
    func onTapSecondary() {
        print("DEBUG : on tap secondary from VC")
        textLabel.isHidden = true
    }
}
