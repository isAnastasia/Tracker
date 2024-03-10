//
//  ScheduleProtocol.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 09.03.2024.
//

import Foundation

protocol ScheduleProtocol: AnyObject {
    func saveSelectedDays(selectedDays: Set<WeekDays>)
}
