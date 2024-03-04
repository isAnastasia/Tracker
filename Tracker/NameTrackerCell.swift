//
//  NameTrackerCell.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 03.03.2024.
//

import Foundation
import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

final class NameTrackerCell: UICollectionViewCell {
    
    static let identifier = "TrackerNameTextFieldCell"
    
    var trackerNameTextField = UITextField()
    let xButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setUpNameTextField()
        //setUpButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setUpButton() {
//        let image = UIImage(systemName: "multiply.circle.fill")
//        xButton.setImage(image, for: .normal)
//
//        trackerNameTextField.rightView = xButton
//        trackerNameTextField.rightViewMode = .always
//        trackerNameTextField.setRightPaddingPoints(16)
//    }
    
    private func setUpNameTextField() {
        contentView.addSubview(trackerNameTextField)
        trackerNameTextField.layer.cornerRadius = 16
        trackerNameTextField.backgroundColor = UIColor(named: "YP Gray")?.withAlphaComponent(0.3) ?? .gray.withAlphaComponent(0.3)
        trackerNameTextField.placeholder = "Введите название трекера"
        trackerNameTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        trackerNameTextField.setLeftPaddingPoints(12)
        
        //trackerNameTextField.becomeFirstResponder()
        
        trackerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackerNameTextField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            trackerNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trackerNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trackerNameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
