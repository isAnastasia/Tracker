//
//  NewEventCreationViewController.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 09.03.2024.
//

import Foundation
import UIKit

final class NewEventCreationViewController: CreationTrackerViewController {
    private var trackerName: String = String()
    private var trackerCategory: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureButtonsCell(cell: ButtonsCell) {
        cell.prepareForReuse()
        cell.delegate = self
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
    
}

extension NewEventCreationViewController: NewHabitCreationDelegate {
    func showCategoriesViewController() {
        // TODO
    }

    func showScheduleViewController(viewController: ScheduleViewController) {
        // NOTHING
    }

}
