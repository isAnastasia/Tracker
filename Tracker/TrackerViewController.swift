//
//  ViewController.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 12.02.2024.
//

import UIKit

final class TrackerViewController: UIViewController {
    var categories: [TrackerCategory]?
    var completedTrackers: [TrackerRecord]?

    private var label = UILabel()
    //private var addButton = UIButton()
    private var navigationBar: UINavigationBar?
    private let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationBar()
        
        
        setLabel()
        
    }
    
    private func setUpNavigationBar() {
        navigationBar = navigationController?.navigationBar
        let addButton = UIBarButtonItem(image:  UIImage(named: "addButton") ?? UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabit))
        addButton.tintColor = UIColor(named: "YP Black")
        navigationBar?.topItem?.leftBarButtonItem = addButton
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        navigationBar?.topItem?.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
    }
    
    @objc
    private func addHabit() {
        
    }
    
    @objc
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd.MM.yyyy" // Формат даты
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("Выбранная дата: \(formattedDate)")
    }
    
    private func setLabel() {
        label.text = "Трекеры"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }


}

