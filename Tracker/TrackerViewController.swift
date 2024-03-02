//
//  ViewController.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 12.02.2024.
//

import UIKit

final class TrackerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord]?

    private var label = UILabel()
    private var navigationBar: UINavigationBar?
    private let datePicker = UIDatePicker()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        initCategories()
        initCollection()
        setUpNavigationBar()
        
        
    }
    private func initCategories() {
        let track1 = Tracker(name: "Ходить в спортзал", color: UIColor(named: "Blue") ?? UIColor.blue, emoji: "😎", schedule: [Days.monday, Days.friday])
        let track2 = Tracker(name: "Прочитать 10 страниц", color: UIColor(named: "Orange") ?? UIColor.orange, emoji: "👻", schedule: [Days.tuesday, Days.friday])
        categories.append(TrackerCategory(title: "Привычки", trackers: [track1, track2]))
        
        let track3 = Tracker(name: "Не есть сладкое", color: UIColor(named: "Fuchsia") ?? UIColor.systemPink, emoji: "💦", schedule: [Days.monday, Days.tuesday, Days.wednesday, Days.thursday, Days.friday])
        let track4 = Tracker(name: "Сходить ко врачу", color: UIColor(named: "Green") ??  UIColor.green, emoji: "🖐️", schedule: [Days.wednesday])
        categories.append(TrackerCategory(title: "Здоровье", trackers: [track3, track4]))
    }
    
    private func initCollection() {
        collectionView.register(TrackerCollectionViewCell.self, forCellWithReuseIdentifier: TrackerCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //collectionView.backgroundColor = .purple
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[0].trackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCollectionViewCell.identifier, for: indexPath) as? TrackerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.prepareForReuse()
        
        let track = categories[indexPath.section].trackers[indexPath.row]
        cell.text = track.name
        cell.color = track.color
        cell.emoji = track.emoji
        
        
        return cell
    }
    
    // MARK: - have no clue
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 46)
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
    
    // MARK: - Private Functions
    
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
        let createTrackerViewController = CreateTrackerViewController()
        let ncCreateTracker = UINavigationController(rootViewController: createTrackerViewController)
        
        //createTrackerViewController.isModalInPresentation = true
        navigationController?.present(ncCreateTracker, animated: true)
        
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


}

