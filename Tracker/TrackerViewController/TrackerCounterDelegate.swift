//
//  TrackerCounterDelegate.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 11.03.2024.
//

import Foundation

protocol TrackerCounterDelegate: AnyObject {
    func increaseTrackerCounter(trackerId: UUID, date: Date)
    func decreaseTrackerCounter(trackerId: UUID, date: Date)
    func checkIfTrackerWasCompletedAtCurrentDay(trackerId: UUID, date: Date) -> Bool
    func calculateTimesTrackerWasCompleted(trackerId: UUID) -> Int
}
