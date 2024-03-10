//
//  EmojiCell.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 10.03.2024.
//

import Foundation
import UIKit

final class EmojiCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = self.isSelected ? (UIColor(named: "YP Gray") ?? .gray) : .clear
            
        }
    }
    
    let label = UILabel()
    static let identifier = "EmojiCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //contentView.backgroundColor = .gray
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        
        
        NSLayoutConstraint.activate([                                    // 5
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpBackground() {
        self.layer.cornerRadius = 16
        //self.backgroundColor = .green
    }
}
