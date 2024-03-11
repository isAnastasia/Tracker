//
//  TrackerCollectionViewCell.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 01.03.2024.
//

import Foundation
import UIKit

protocol TrackerCounterDelegate: AnyObject {
    func increaseTrackerCounter(trackerId: UUID, date: Date)
    func decreaseTrackerCounter(trackerId: UUID, date: Date)
    func checkIfTrackerWasCompletedAtCurrentDay(trackerId: UUID, date: Date) -> Bool
    func calculateTimesTrackerWasCompleted(trackerId: UUID) -> Int
}

struct TrackerInfoCell {
    let id: UUID
    let name: String
    let color: UIColor
    let emoji: String
    
    let daysCount: Int
    let currentDay: Date
    let state: State
    
    init(id: UUID, name: String, color: UIColor, emoji: String, daysCount: Int, currentDay: Date, state: State) {
        self.id = id
        self.name = name
        self.color = color
        self.emoji = emoji
        self.daysCount = daysCount
        self.currentDay = currentDay
        self.state = state
    }
}

final class TrackerCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrackerCell"
    
    weak var counterDelegate: TrackerCounterDelegate?
    
    var trackerInfo: TrackerInfoCell? {
        didSet {
            titleLabel.text = trackerInfo?.name
            emojiLabel.text = trackerInfo?.emoji
            card.backgroundColor = trackerInfo?.color
            
            daysCount = trackerInfo?.daysCount ?? daysCount
            color = trackerInfo?.color
            updateAddButton()
        }
    }
    var color: UIColor?
    var daysCount: Int = 0 {
        didSet {
            updateDaysCountLabel()
        }
    }
    
    var isPinned: Bool = false
    
    let addButton = UIButton(type: .custom)
    let card = UIView()
    let circle = UIView()
    let emojiLabel = UILabel()
    let titleLabel = UILabel()
    let pinImageView = UIImageView()
    let daysCountLabel = UILabel()
    
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
    
    private func checkIfTrackerWasCompleted() -> Bool {
        guard let id = trackerInfo?.id,
              let currentDay = trackerInfo?.currentDay,
              let delegate = counterDelegate else {
            return false
        }
        return delegate.checkIfTrackerWasCompletedAtCurrentDay(trackerId: id, date: currentDay)
    }
    func updateDaysCountLabel() {
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
    }
    
    private func setUpDaysCountLabel() {
        contentView.addSubview(daysCountLabel)
        daysCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        updateDaysCountLabel()
        
        daysCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            daysCountLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            daysCountLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8)
        ])
    }
    func updateAddButton() {
        if checkIfTrackerWasCompleted() {
            addButton.setImage(UIImage(named: "Done"), for: .normal)
            addButton.backgroundColor = color?.withAlphaComponent(0.3)
        } else {
            addButton.setImage(UIImage(systemName: "plus"), for: .normal)
            addButton.backgroundColor = color
        }
        addButton.layer.cornerRadius = 17
        addButton.tintColor = UIColor.white
    }
    private func setUpAddButton() {
        contentView.addSubview(addButton)
        updateAddButton()
        addButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 34),
            addButton.heightAnchor.constraint(equalToConstant: 34),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    @objc
    func buttonClicked() {
        if !checkIfTrackerWasCompleted() {
            guard let id = trackerInfo?.id,
                  let currentDay = trackerInfo?.currentDay,
                    let state = trackerInfo?.state else {
                return
            }
            
            
            if currentDay > Date() {
                return
            }
            addButton.setImage(UIImage(named: "Done"), for: .normal)
            addButton.backgroundColor = color?.withAlphaComponent(0.3)
            
            // увеличить счетчик
            counterDelegate?.increaseTrackerCounter(trackerId: id, date: currentDay)
            daysCount = counterDelegate?.calculateTimesTrackerWasCompleted(trackerId: id) ?? daysCount
        } else {
            
            addButton.setImage(UIImage(systemName: "plus"), for: .normal)
            addButton.backgroundColor = color
            guard let id = trackerInfo?.id ,
                  let currentDay = trackerInfo?.currentDay else {
                return
            }
            // уменьшить счетчик
            counterDelegate?.decreaseTrackerCounter(trackerId: id, date: currentDay)
            daysCount = counterDelegate?.calculateTimesTrackerWasCompleted(trackerId: id) ?? daysCount
        }
        
    }
    
    private func setUpPinImageView() {
        let image = UIImage(named: "pin.png")
        //pinImageView.image = image
        card.addSubview(pinImageView)
        
        pinImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pinImageView.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            pinImageView.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -12)
        ])
    }
    
    private func setUpTitle() {
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.numberOfLines = 0
        card.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 12 * 2),
            titleLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -12),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12)
        ])
    }
    
    private func setUpEmojiLabel() {
        card.addSubview(emojiLabel)
        emojiLabel.font = UIFont.systemFont(ofSize: 13)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor)
        ])
    }
    
    private func setUpCard() {
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
