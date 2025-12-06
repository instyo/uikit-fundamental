//
//  StacksViewController.swift
//  UIKitTutorial
//
//  Created by ikhwan on 06/12/25.
//

import UIKit

class StacksViewController: UIViewController {
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect1 = createRectangle()
        rect1.backgroundColor = .systemPink
        
        let rect2 = createRectangle()
        rect2.backgroundColor = .systemBlue
        
        let rect3 = createRectangle()
        rect3.backgroundColor = .systemYellow
        
        stackView.addArrangedSubview(rect1)
        stackView.addArrangedSubview(rect2)
        stackView.addArrangedSubview(rect3)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func createRectangle() -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        view.layer.cornerRadius = 16
        return view
    }
    
}

#Preview {
    StacksViewController()
}
