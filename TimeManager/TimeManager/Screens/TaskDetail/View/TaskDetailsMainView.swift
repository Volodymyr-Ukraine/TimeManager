//
//  TaskDetailsMainView.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

class TaskDetailsMainView: UIView {
    
    // MARK: -
    // MARK: Properties
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var priorityArrowImage: UIImageView?
    @IBOutlet var priorityLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var notificationLabel: UILabel?
    private var data: TaskData?
    public var eventHandler: ((TaskDetailEvent)->())?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: -
    // MARK: Methods
    
    @IBAction func backPressed(_ sender: Any) {
        self.eventHandler?(.backPressed)
    }
    @IBAction func editPressed(_ sender: Any) {
        self.eventHandler?(.editPressed(self.data))
    }
    @IBAction func deleteEventPressed(_ sender: Any) {
        self.eventHandler?(.deleteTask(self.data))
    }
    
    public func setData(_ data: TaskData?){
        self.data = data
        self.titleLabel?.text = data?.description ?? ""
        self.dateLabel?.text = data?.longDate
        self.priorityLabel?.text = data?.priority.rawValue.capitalized
        self.descriptionLabel?.text = data?.description
        self.notificationLabel?.text = data?.date
    }
}
