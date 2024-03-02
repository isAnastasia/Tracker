//
//  TrackerCollectionViewCell.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 01.03.2024.
//

import Foundation
import UIKit

final class TrackerCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrackerCell"
    
//    var emoji: String = "😻"
//    var text: String = "Полить цветы"
//    var color: UIColor = UIColor.orange
    var emoji: String? {
        didSet {
            emojiLabel.text = emoji
        }
    }
    var text: String? {
        didSet {
            titleLabel.text = text
        }
    }
    var color: UIColor? {
        didSet {
            card.backgroundColor = color
            addButton.backgroundColor = color
        }
    }
    
    var daysCount: Int = 0
    var isPinned: Bool = false
    
    var addButton = UIButton(type: .custom)
    var card = UIView()
    var circle = UIView()
    var emojiLabel = UILabel()
    var titleLabel = UILabel()
    var pinImageView = UIImageView()
    var daysCountLabel = UILabel()
    
    // Конструктор:
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(card)
        setUpCard()
        
        card.addSubview(circle)
        setUpCircle()
        
        setUpEmojiLabel()
        
        setUpTitle()
        
        setUpPinImageView()
        setUpAddButton()
        setUpDaysCountLabel()
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpDaysCountLabel() {
        contentView.addSubview(daysCountLabel)
        
        let digit = daysCount % 10
        var days: String
        switch digit {
        case 1:
            days = "день"
        case 2, 3, 4:
            days = "дня"
        default:
            days = "дней"
        }
        daysCountLabel.text = String(daysCount) + " " + days
        daysCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        daysCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            daysCountLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            daysCountLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8)
        ])
    }
    
    private func setUpAddButton() {
        contentView.addSubview(addButton)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        //addButton.backgroundColor = color
        addButton.layer.cornerRadius = 17
        addButton.tintColor = UIColor.white
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 34),
            addButton.heightAnchor.constraint(equalToConstant: 34),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    private func setUpPinImageView() {
        let image = UIImage(named: "pin.png")
        pinImageView.image = image
        card.addSubview(pinImageView)
        
        pinImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pinImageView.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            pinImageView.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -12)
        ])
    }
    
    private func setUpTitle() {
        card.addSubview(titleLabel)
        //titleLabel.text = text
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.numberOfLines = 2
        titleLabel.contentMode = .bottom
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 34),
            titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 12 * 2),
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 44),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12)
        ])
    }
    
    private func setUpEmojiLabel() {
        card.addSubview(emojiLabel)
        //emojiLabel.text = emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 13)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor)
        ])
    }
    
    private func setUpCard() {
        //card.backgroundColor = color
        card.layer.cornerRadius = 16
        card.layer.masksToBounds = true
        
        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalToConstant: 90),
            card.widthAnchor.constraint(equalToConstant: contentView.frame.width)
        ])
    }
    
    private func setUpCircle() {
        circle.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        circle.layer.cornerRadius = 12
        circle.layer.masksToBounds = true
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12),
            circle.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),
            circle.widthAnchor.constraint(equalToConstant: 24),
            circle.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
