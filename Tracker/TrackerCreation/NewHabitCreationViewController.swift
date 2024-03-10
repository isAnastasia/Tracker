//
//  CreateHabbitViewController.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 03.03.2024.
//

import Foundation
import UIKit


final class NewHabitCreationViewController: CreationTrackerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureButtonsCell(cell: ButtonsCell) {
        cell.prepareForReuse()
        cell.scheduleDelegate = self
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
    
    override func checkIfSaveButtonCanBePressed() {
        if trackerName != nil,
           selectedEmoji != nil,
           selectedColor != nil,
           trackerCategory != nil,
           !selectedWeekDays.isEmpty
        {
            saveButtonCanBePressed = true
        } else {
            saveButtonCanBePressed = false
        }
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

//MARK: - ShowScheduleDelegate

extension NewHabitCreationViewController: ShowScheduleDelegate {
    func showScheduleViewController(viewController: ScheduleViewController) {
        viewController.sheduleDelegate = self
        viewController.selectedDays = selectedWeekDays
        navigationController?.pushViewController(viewController, animated: true)
    }
}


//MARK: - ScheduleProtocol

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
