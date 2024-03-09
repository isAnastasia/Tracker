//
//  Tracker.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 18.02.2024.
//

import Foundation
import UIKit

public struct Tracker {
    let id = UUID()
    let name: String
    let color: UIColor
    let emoji: String
    let schedule: [WeekDays]
    
    init(name: String, color: UIColor, emoji: String, schedule: [WeekDays]) {
        self.name = name
        self.color = color
        self.emoji = emoji
        self.schedule = schedule
    }
}


enum WeekDays: Int {
    
    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var name: String {
        switch self {
        case .monday:
            return "Понедельник"
        case .tuesday:
            return "Вторник"
        case .wednesday:
            return "Среда"
        case .thursday:
            return "Четверг"
        case .friday:
            return "Пятница"
        case .saturday:
            return "Суббота"
        case .sunday:
            return "Воскресенье"
        }
    }
    
    var shortName: String {
        switch self {
        case .monday:
            return "Пн"
        case .tuesday:
            return "Вт"
        case .wednesday:
            return "Ср"
        case .thursday:
            return "Чт"
        case .friday:
            return "Пт"
        case .saturday:
            return "Сб"
        case .sunday:
            return "Вс"
        }
    }
}
