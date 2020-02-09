//
//  TaskListTableViewCell.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: Properties
    
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var arrowImage: UIImageView?
    @IBOutlet var priorityLabel: UILabel?
    private var data: InternalTaskData?
    public var eventHandler: ((InternalTaskData?)->())?
    
    // MARK: -
    // MARK: Init and Deinit
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: -
    // MARK: Methods
    
    @IBAction func infoPressed(_ sender: Any) {
        self.eventHandler?(self.data)
    }
    
    public func setData(_ data: InternalTaskData) {
        self.data = data
        self.descriptionLabel?.text = data.description
        self.dateLabel?.text = data.date + "    "
        self.priorityLabel?.text = data.priority.rawValue.capitalized
    }
}
