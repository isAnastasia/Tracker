//
//  TrackerCreationDelegate.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 11.03.2024.
//

import Foundation

protocol TrackerCreationDelegate: AnyObject {
    func createTracker(tracker: Tracker, category: String)
}
