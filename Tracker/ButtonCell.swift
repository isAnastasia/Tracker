//
//  ButtonCell.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 03.03.2024.
//

import Foundation
import UIKit


final class ButtonCell: UICollectionViewCell {
    static let identifier = "ButtonCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
