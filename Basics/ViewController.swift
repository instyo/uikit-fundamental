//
//  ViewController.swift
//  UIKitTutorial
//
//  Created by ikhwan on 06/12/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func primaryButtonTapped(_ sender: UIButton) {
        greetingLabel.text = "Hello, Ikhwan!"
    }
    
}

