//
//  LabelsTutorialViewController.swift
//  UIKitTutorial
//
//  Created by ikhwan on 06/12/25.
//

import UIKit

class LabelsTutorialViewController: UIViewController {
    
    private var textLabel = UILabel()
    private var subtitleLabel : UILabel = {
        let label = UILabel()
        label.text = "This is a subtitle for the best UIKit Course Ever"
        label.textColor = .gray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = "Hello World!"
        textLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8).isActive = true
        
        view.backgroundColor = .yellow
    }
}

#Preview {
    LabelsTutorialViewController()
}
