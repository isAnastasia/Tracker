//
//  ConfigureUIProtocol.swift
//  Tracker
//
//  Created by Anastasia Gorbunova on 11.03.2024.
//

import Foundation

protocol ConfigureUIForTrackerCreationProtocol: AnyObject {
    func configureButtonsCell(cell: ButtonsCell)
    func setUpBackground()
    func calculateTableViewHeight(width: CGFloat) -> CGSize
    func checkIfSaveButtonCanBePressed()
}
