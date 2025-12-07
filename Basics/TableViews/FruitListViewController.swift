//
//  FruitListViewController.swift
//  UIKitTutorial
//
//  Created by ikhwan on 07/12/25.
//

import UIKit

class FruitListViewController: UIViewController {

    let fruits : [String] = ["🍎 Apple", "🍌 Banana", "🍊 Orange", "🍇 Grape", "🥭 Mango",
                             "🍓 Strawberry", "🍉 Watermelon", "🍑 Peach", "🍒 Cherry", "🥝 Kiwi"]
    
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorite Fruits"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FruitCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.frame = view.bounds
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension FruitListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FruitCell", for: indexPath)
        
        cell.textLabel?.text = fruits[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFruit = fruits[indexPath.row]
        
        let alert = UIAlertController(title: "Yummy! 😋", message: "You selected : \(selectedFruit)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
