//
//  ActionButtonView.swift
//  UIKitTutorial
//
//  Created by ikhwan on 06/12/25.
//

import UIKit

protocol ActionButtonViewDelegate: AnyObject {
    func onTapPrimary()
    func onTapSecondary()
}

class ActionButtonView: UIView {
    
    weak var delegate: ActionButtonViewDelegate?

    private var primaryActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Primary Action", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private var secondayActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Secondary Action", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(primaryActionButton)
        primaryActionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        primaryActionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        primaryActionButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        primaryActionButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(secondayActionButton)
        secondayActionButton.topAnchor.constraint(equalTo: primaryActionButton.bottomAnchor, constant: 16).isActive = true
        secondayActionButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        primaryActionButton.addTarget(self, action: #selector(handlePrimaryTap), for: .touchUpInside)
        secondayActionButton.addTarget(self, action: #selector(handleSecondaryTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handlePrimaryTap() {
        print("DEBUG : Primary button tapped in view..")
        delegate?.onTapPrimary()
    }
    
    @objc func handleSecondaryTap() {
        print("DEBUG : Secondary button tapped in view..")
        delegate?.onTapSecondary()
    }
}
