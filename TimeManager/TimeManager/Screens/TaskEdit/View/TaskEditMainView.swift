//
//  TaskEditMainView.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

class TaskEditMainView: UIView {
    
    // MARK: -
    // MARK: Properties
    
    @IBOutlet var titleTextView: UITextView?

    @IBOutlet var descriptionTextView: UITextView?
    @IBOutlet var highPriorityButton: UIButton?
    @IBOutlet var mediumPriorityButton: UIButton?
    @IBOutlet var lowPriorityButton: UIButton?
    
    @IBOutlet var notificationChooseButton: UIButton?
    @IBOutlet var bottomGapConstraints: NSLayoutConstraint?
    
    public var eventHandler: ((TaskEditEvents)->())?
    private var data: InternalTaskData?
    
    private var priority: PriorityEnum? {
        didSet {
            let paint: ((UIButton?, UIColor, UIColor))->() = { arg0 in
                let (btn, back, front) = arg0
                btn?.backgroundColor = back
                btn?.setTitleColor(front, for: .normal)
                btn?.setTitleColor(back, for: .highlighted)
            }
            [self.highPriorityButton,
             self.mediumPriorityButton,
             self.lowPriorityButton].forEach{
                paint(($0, .clear, .systemBlue))
                $0?.layer.cornerRadius = 10
            }
            
            switch self.priority {
            case .high:
                paint((self.highPriorityButton, .systemBlue, .white))
            case .low:
                paint((self.lowPriorityButton, .systemBlue, .white))
            case .normal:
                paint((self.mediumPriorityButton, .systemBlue, .white))
            case .none:
                return
            }
        }
    }
    
    // MARK: -
    // MARK: Methods
    
    @IBAction func highPriorityChoosen(_ sender: Any) {
        self.priority = .high
    }
    
    @IBAction func mediumPriorityChoosen(_ sender: Any) {
        self.priority = .normal
    }
    
    @IBAction func lowPriorityChoosen(_ sender: Any) {
        self.priority = .low
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.eventHandler?(.back)
    }
    
    @IBAction func deleteEventPressed(_ sender: Any) {
        self.eventHandler?(.deleteTask(self.data?.id))
    }
    
    @IBAction func saveEventPressed(_ sender: Any) {
        if (self.titleTextView?.text ?? "" ) != "" {
            self.eventHandler?(
                .saveTask(TaskData(id: self.data?.id ?? -1,
                        title: self.titleTextView?.text ?? "",
                        dueBy: Int(Date(timeIntervalSinceNow: 0).timeIntervalSince1970.rounded()),
                        priority: self.priority ?? .low)
                )
            )
        }
    }
    
    @IBAction func notificationChangePressed(_ sender: Any) {
        
    }
    
    public func setData(_ data: InternalTaskData?){
        self.titleTextView?.text = data?.title ?? ""
        self.descriptionTextView?.text = data?.title ?? ""
        self.priority = data?.priority
        self.data = data
    }

}
