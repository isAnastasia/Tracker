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
    //let schedule: [WeekDays]
    let schedule: Set<WeekDays>
    
//    init(name: String, color: UIColor, emoji: String, schedule: [WeekDays]) {
//        self.name = name
//        self.color = color
//        self.emoji = emoji
//        self.schedule = schedule
//    }
    init(name: String, color: UIColor, emoji: String, schedule: Set<WeekDays>) {
        self.name = name
        self.color = color
        self.emoji = emoji
        self.schedule = schedule
    }
}
