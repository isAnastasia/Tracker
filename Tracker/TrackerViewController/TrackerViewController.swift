//
//  ViewController.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 12.02.2024.
//

import UIKit

final class TrackerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var currentCategories: [TrackerCategory] = {
        filterCategoriesToshow()
    }()
    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord]?
    var currentDate = Date()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    private var label = UILabel()
    private var navigationBar: UINavigationBar?
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        initCategories()
        initCollection()
        setUpNavigationBar()
    }
    
    // MARK: - Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentCategories[section].trackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCollectionViewCell.identifier, for: indexPath) as? TrackerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.prepareForReuse()
        
        let track = currentCategories[indexPath.section].trackers[indexPath.row]
        cell.text = track.name
        cell.color = track.color
        cell.emoji = track.emoji
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (currentCategories.count == 0) {
            showPlaceHolder()
        } else {
            collectionView.backgroundView = nil
        }
        return currentCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionReusableView.identifier,
                for: indexPath) as? HeaderCollectionReusableView {
                
                sectionHeader.headerLabel.text = categories[indexPath.section].title
                    
                return sectionHeader
            }
            
        }
        return UICollectionReusableView()
    }
 
    // MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - 16 * 2 - 9
        let cellWidth =  availableWidth / 2
        return CGSize(width: cellWidth, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 46)
    }
    
// MARK: - Private Functions
    
    private func initCategories() {
        let track1 = Tracker(name: "Ходить в спортзал", color: UIColor(named: "Blue") ?? UIColor.blue, emoji: "😎", schedule: [WeekDays.monday, WeekDays.friday])
        let track2 = Tracker(name: "Прочитать 10 страниц", color: UIColor(named: "Orange") ?? UIColor.orange, emoji: "👻", schedule: [WeekDays.tuesday, WeekDays.friday])
        categories.append(TrackerCategory(title: "Привычки", trackers: [track1, track2]))
        
        let track3 = Tracker(name: "Не есть сладкое", color: UIColor(named: "Fuchsia") ?? UIColor.systemPink, emoji: "💦", schedule: [WeekDays.monday, WeekDays.tuesday, WeekDays.wednesday, WeekDays.thursday, WeekDays.friday])
        let track4 = Tracker(name: "Сходить ко врачу", color: UIColor(named: "Green") ??  UIColor.green, emoji: "🖐️", schedule: [WeekDays.wednesday])
        let track5 = Tracker(
            name: "Пробежать 10 км",
            color: UIColor(named: "Red") ?? UIColor.red,
            emoji: "⚽",
            schedule: [WeekDays.sunday])
        categories.append(TrackerCategory(title: "Здоровье", trackers: [track3, track4, track5]))
    }
    
    //MARK: - Collection Initialization
    private func initCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(TrackerCollectionViewCell.self, forCellWithReuseIdentifier: TrackerCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func showPlaceHolder() {
        let backgroundView = PlaceHolderView(frame: collectionView.frame)
        backgroundView.setUpNoTrackersState()
        collectionView.backgroundView = backgroundView
    
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
        
        navigationBar?.prefersLargeTitles = true
        navigationBar?.topItem?.title = "Трекеры"

        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
    }
    
    @objc
    private func addHabit() {
        let createTrackerViewController = NewTrackerViewController()
        let ncCreateTracker = UINavigationController(rootViewController: createTrackerViewController)

        navigationController?.present(ncCreateTracker, animated: true)
    }
    
    @objc
    private func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("Выбранная дата: \(formattedDate)")
        
        currentDate = selectedDate
        updateCollection()
    }
    
    private func filterCategoriesToshow() -> [TrackerCategory] {
        currentCategories = []
        let weekdayInt = Calendar.current.component(.weekday, from: currentDate)
        print(weekdayInt)
        let day = (weekdayInt == 1) ?  WeekDays(rawValue: 7) : WeekDays(rawValue: weekdayInt - 1)
        
        categories.forEach { category in
            let title = category.title
            let trackers = category.trackers.filter { tracker in
                tracker.schedule.contains(day!)
            }
            
            if trackers.count > 0 {
                currentCategories.append(TrackerCategory(title: title, trackers: trackers))
            }
        }
        
        return currentCategories
    }

    private func updateCollection() {
        currentCategories = filterCategoriesToshow()
        collectionView.reloadData()
    }
}

