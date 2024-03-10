//
//  ColorCell.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 10.03.2024.
//

import Foundation
import UIKit

final class ColorCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = self.isSelected ? 3 : 0
            self.layer.borderColor = self.isSelected ? colorView.backgroundColor?.withAlphaComponent(0.3).cgColor : UIColor.clear.cgColor
        }
    }
    
    let colorView = UIView()
    static let identifier = "ColorCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        
        colorView.layer.cornerRadius = 8
        contentView.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
