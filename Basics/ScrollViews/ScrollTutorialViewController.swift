//
//  ScrollTutorialViewController.swift
//  UIKitTutorial
//
//  Created by ikhwan on 06/12/25.
//

import UIKit

class ScrollTutorialViewController: UIViewController {
    
    private let rectSize: Double = 200.0
    private let rectCount: Int = 20
    
    private var scrollView: UIScrollView = UIScrollView()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1 ..< rectCount {
            let rect = createRectangle()
            stackView.addArrangedSubview(rect)
        }
        
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        scrollView.contentSize.height = (rectSize * CGFloat(rectCount)) + 64
    }
    

    private func createRectangle() -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: rectSize).isActive = true
        view.widthAnchor.constraint(equalToConstant: rectSize).isActive = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .gray
        return view
    }

    
}


extension ScrollTutorialViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("DEBUG : view scroll : \(scrollView.contentOffset)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("DEBUG : view scroll stop")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("DEBUG : view scroll end drag")
    }
}
