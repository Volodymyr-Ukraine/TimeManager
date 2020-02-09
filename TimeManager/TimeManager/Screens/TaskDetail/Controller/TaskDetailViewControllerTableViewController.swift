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
    case editPressed(InternalTaskData?)
    case deleteTask(InternalTaskData?)
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
            self.mainView?.eventHandler = {[weak self] event in
                switch event {
                case .deleteTask(let data):
                    let success: ()->() = { [weak self] in
                        self?.eventHandler?(.deleteTask(data))
                    }
                    let error: (TaskList)->Void = { [weak self] list in
                        let alert = UIAlertController(title: "Error in deleting", message: list.message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self?.present(alert, animated: true)
                    }
                    RequesterURL.ask.deleteTask(id: data?.id, toDoIfSuccess: success, toDoIfError: error)
                default:
                    self?.eventHandler?(event)
                }
            }
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
}
