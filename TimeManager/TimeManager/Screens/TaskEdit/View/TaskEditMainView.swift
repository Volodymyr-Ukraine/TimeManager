//
//  TaskEditMainView.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

class TaskEditMainView: UIView {

    @IBOutlet var titleTextView: UITextView!

    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var highPriorityButton: UIButton!
    @IBOutlet var mediumPriorityButton: UIButton!
    @IBOutlet var lowPriorityButton: UIButton!
    
    @IBOutlet var notificationChooseButton: UIButton!
    @IBOutlet var bottomGapConstraints: NSLayoutConstraint!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func backPressed(_ sender: Any) {
    }
    @IBAction func deleteEventPressed(_ sender: Any) {
    }
    @IBAction func notificationChangePressed(_ sender: Any) {
    }
}
