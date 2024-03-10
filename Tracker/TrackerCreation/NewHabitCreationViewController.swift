//
//  CreateHabbitViewController.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 03.03.2024.
//

import Foundation
import UIKit


final class NewHabitCreationViewController: CreationTrackerViewController {
    private var selectedWeekDays: Set<WeekDays> = []
    private var trackerName: String = String()
    private var trackerCategory: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureButtonsCell(cell: ButtonsCell) {
        cell.prepareForReuse()
        cell.delegate = self
        cell.state = .Habit
    }
    
    override  func setUpBackground() {
        self.title = "Новая привычка"
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
    
    override func calculateTableViewHeight(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: 150)
    }
    
    
    //MARK: - Private Methods

    private func convertSelectedDaysToString() -> String {
        var scheduleSubText = String()
        selectedWeekDays.sorted {
            $0.rawValue < $1.rawValue
        }.forEach { day in
            scheduleSubText += day.shortName
            scheduleSubText += ", "
        }
        if (scheduleSubText.count > 1) {
            scheduleSubText = String(scheduleSubText.dropLast(2))
        }

        return scheduleSubText
    }
}



//MARK: - NewHabitCreationDelegate

extension NewHabitCreationViewController: NewHabitCreationDelegate {
    func showCategoriesViewController() {
        // TODO
    }

    func showScheduleViewController(viewController: ScheduleViewController) {
        viewController.sheduleDelegate = self
        viewController.selectedDays = selectedWeekDays
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension NewHabitCreationViewController: ScheduleProtocol {
    func saveSelectedDays(selectedDays: Set<WeekDays>) {
        if (selectedDays.isEmpty) {
            selectedWeekDays = []
        } else {
            selectedWeekDays = []
            selectedDays.forEach {
                selectedWeekDays.insert($0)
            }
        }

        if let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 1)) as? ButtonsCell  {
            cell.updateSubTitle(
                forCellAt: IndexPath(row: 1, section: 0),
                text: convertSelectedDaysToString())
        }
    }

}
