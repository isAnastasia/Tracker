//
//  NewEventCreationViewController.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 09.03.2024.
//

import Foundation
import UIKit

final class NewEventCreationViewController: CreationTrackerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureButtonsCell(cell: ButtonsCell) {
        cell.prepareForReuse()
        //cell.scheduleDelegate = self
        cell.state = .Event
    }
    
    override  func setUpBackground() {
        self.title = "Новое нерегулярное событие"
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
    
    override func calculateTableViewHeight(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: 75)
    }
    
    override func checkIfSaveButtonCanBePressed() {
        if trackerName != nil,
           selectedEmoji != nil,
           selectedColor != nil,
           trackerCategory != nil
        {
            saveButtonCanBePressed = true
        } else {
            saveButtonCanBePressed = false
        }
    }
    
}

//extension NewEventCreationViewController: ShowScheduleDelegate {
//    func showCategoriesViewController() {
//        // TODO
//    }
//
//    func showScheduleViewController(viewController: ScheduleViewController) {
//        // NOTHING
//    }
//}
