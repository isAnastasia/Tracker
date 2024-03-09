//
//  CreateHabbitViewController.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 03.03.2024.
//

import Foundation
import UIKit


final class NewHabitCreationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var selectedWeekDays: Set<WeekDays> = []
    private var trackerName: String = String()
    private var trackerCategory: String = String()
    
    private let stackView = UIStackView()
    private let saveButton = UIButton()
    private let cancelButton = UIButton()
    private var saveButtonCanBePressed: Bool? {
        didSet {
            switch saveButtonCanBePressed {
            case true:
                saveButton.backgroundColor = .black
            case false:
                saveButton.backgroundColor = .lightGray
            
            case .none:
                saveButton.backgroundColor = .lightGray
            case .some(_):
                saveButton.backgroundColor = .black
            }
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Новая привычка"
        view.backgroundColor = .white
        
        navigationItem.hidesBackButton = true
        setUpStackViewWithButtons()
        initCollection()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func calcelButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc
    private func saveButtonPressed() {
        //create habit
        
    }
    
    //MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("hello")
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NameTrackerCell.identifier, for: indexPath) as? NameTrackerCell else {
                return UICollectionViewCell()
            }
            cell.prepareForReuse()
            
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCell.identifier, for: indexPath) as? ButtonsCell else {
                return UICollectionViewCell()
            }
            cell.prepareForReuse()
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    //MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width - 16 * 2
        
        switch indexPath.section {
        case 0:
            return CGSize(width: cellWidth, height: 75)
        case 1:
            return CGSize(width: cellWidth, height: 150)
        default:
            return CGSize(width: cellWidth, height: 75)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 16)
    }
    
    //MARK: - Collection initialisation
    private func initCollection() {
        collectionView.register(NameTrackerCell.self, forCellWithReuseIdentifier: NameTrackerCell.identifier)
        
        collectionView.register(ButtonsCell.self, forCellWithReuseIdentifier: ButtonsCell.identifier)
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: stackView.topAnchor)
        ])
        
    }
    
    //MARK: - Setting Up StackView & Buttons
    private func setUpSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = UIColor(named: "YP Dark Gray") ?? .gray
        saveButton.layer.cornerRadius = 16
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    private func setUpCancelButton() {
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.clipsToBounds = true
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 16
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.red.cgColor
        cancelButton.backgroundColor = .white
        cancelButton.addTarget(self, action: #selector(calcelButtonPressed), for: .touchUpInside)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setUpStackViewWithButtons() {
        setUpCancelButton()
        setUpSaveButton()
        
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 8
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(saveButton)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
