//
//  ButtonsCell.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 05.03.2024.
//

import Foundation
import UIKit

enum State {
    case Schedule
    case Category
}
protocol NewHabitCreationDelegate: AnyObject {
    func showScheduleViewController(viewController: ScheduleViewController)
}

final class ButtonsCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    static let identifier = "ButtonsCell"
    
    weak var delegate: NewHabitCreationDelegate?
    
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
    
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            //TODO categories view controller
        } else if indexPath.row == 1 {
            print("Schedule")
            delegate?.showScheduleViewController(viewController: ScheduleViewController())
            //navigationController?.pushViewController(scheduleVC, animated: true)
        }
    }
    
    
    //MARK: - Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: indexPath) as? ButtonTableViewCell else  {
            return UITableViewCell()
        }
        cell.prepareForReuse()
        switch indexPath.row {
        case 0:
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.titleLabel.text = "Категории"
            return cell
        case 1:
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.titleLabel.text = "Расписание"
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
