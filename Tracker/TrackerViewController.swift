//
//  ViewController.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 12.02.2024.
//

import UIKit

final class TrackerViewController: UIViewController {

    private var label = UILabel()
    private var addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setAddButton()
        setLabel()
        
    }
    
    private func setAddButton() {
        addButton.setImage(UIImage(named: "Add tracker"), for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.tintColor = UIColor.black
        
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 42),
            addButton.heightAnchor.constraint(equalToConstant: 42),
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6)
        ])
    }
    private func setLabel() {
        label.text = "Трекеры"
        //label.font = .systemFont(ofSize: 34)
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 1),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }


}

