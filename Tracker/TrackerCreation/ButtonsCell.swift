//
//  ButtonsCell.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 05.03.2024.
//

import Foundation
import UIKit

enum State {
    case Habit
    case Event
}

protocol NewHabitCreationDelegate: AnyObject {
    func showScheduleViewController(viewController: ScheduleViewController)
    func showCategoriesViewController()
}

final class ButtonsCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    static let identifier = "ButtonsCell"
    
    weak var delegate: NewHabitCreationDelegate?
    var state: State?
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initTable() {
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.tableHeaderView = UIView()
        
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func updateSubTitle(forCellAt indexPath: IndexPath, text: String) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? ButtonTableViewCell  else {
            return
        }
        cell.setUpSubtitleLabel(text: text)
    }
    
    private func configureCell(cell: ButtonTableViewCell, at indexPath: IndexPath) {
        cell.prepareForReuse()
        
        guard let state = state else {
            return
        }
        if state == .Habit {
            switch indexPath.row {
            case 0:
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.titleLabel.text = "Категории"
            case 1:
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.titleLabel.text = "Расписание"
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            default:
                return
            }
        } else {
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.titleLabel.text = "Категории"
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
        }
        
    }
    
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            //TODO categories view controller
            delegate?.showCategoriesViewController()
        } else if indexPath.row == 1 {
            delegate?.showScheduleViewController(viewController: ScheduleViewController())
            //navigationController?.pushViewController(scheduleVC, animated: true)
        }
    }
    
    
    //MARK: - Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if state == .Habit {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: indexPath) as? ButtonTableViewCell else  {
            return UITableViewCell()
        }
        configureCell(cell: cell, at: indexPath)
        
//        cell.prepareForReuse()
//        switch indexPath.row {
//        case 0:
//            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//            cell.titleLabel.text = "Категории"
//            return cell
//        case 1:
//            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            cell.titleLabel.text = "Расписание"
//            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
//
//            return cell
//        default:
//            return UITableViewCell()
//        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
