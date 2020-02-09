//
//  TaskListMainView.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

class TaskListMainView: UIView {
    
    // MARK: -
    // MARK: Properties

    @IBOutlet var taskTable: UITableView?
    @IBOutlet var bellItem: UIBarButtonItem?
    @IBOutlet var addTaskButton: UIButton?
    public var bellState: Bool = true {
        didSet{
            if bellState {
                bellItem?.image = UIImage(named: "empty_bell")
            } else {
                bellItem?.image = UIImage(named: "filled_bell")
            }
        }
    }
    public var eventHandler: ((TaskListEvents)->())?
    
    // MARK: -
    // MARK: Init and Deinit
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let btn = self.addTaskButton else {return}
        self.addTaskButton?.layer.cornerRadius = btn.bounds.width / 2
    }
    
    // MARK: -
    // MARK: Actions and Methods
    
    @IBAction func bellPressed(_ sender: Any) {
        self.bellState = !self.bellState
    }
    @IBAction func sortPressed(_ sender: Any) {
        self.eventHandler?(.sortPressed)
    }
    @IBAction func addTaskButtonPressed(_ sender: Any) {
        self.eventHandler?(.addTask)
    }
    
}
