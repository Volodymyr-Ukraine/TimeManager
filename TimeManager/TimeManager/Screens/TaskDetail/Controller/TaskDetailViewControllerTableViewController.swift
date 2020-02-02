//
//  TaskDetailViewControllerTableViewController.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

enum TaskDetailEvent{
    case backPressed
    case editPressed(TaskData?)
    case deleteTask(TaskData?)
}

class TaskDetailViewController: RootViewController, StoryboardLoadable {
    // MARK: -
    // MARK: Properties
    
    private var mainView: TaskDetailsMainView? {
        return self.view as? TaskDetailsMainView
    }
    public var model: TaskDetailModel = TaskDetailModel()
    public var eventHandler: ((TaskDetailEvent)->())? {
        didSet{
            self.mainView?.eventHandler = self.eventHandler
        }
    }
    
    // MARK: -
    // MARK: Init and Deinit
    
    static public func startVC() -> TaskDetailViewController {
        let contr = self.loadFromStoryboard(storyboardName: "TaskDetailStoryboard")
        return contr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView?.setData(self.model.data)

    }

    // MARK: -
    // MARK: Table view data source

}
