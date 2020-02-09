//
//  TaskEditController.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

enum TaskEditEvents{
    case back
    case deleteTask(Int?)
    case saveTask(TaskData?)
}

class TaskEditViewController: RootViewController, StoryboardLoadable {
    // MARK: -
    // MARK: Properties

    public var model = TaskEditModel()
    private var mainView: TaskEditMainView? {
        return self.view as? TaskEditMainView
    }
    public var eventHandler: ((TaskEditEvents)->())? {
        didSet {
            self.mainView?.eventHandler = { [weak self] event in
                switch event {
                case .deleteTask(let id):
                    let success = { [weak self] in
                        guard let this = self else {return}
                        self?.eventHandler?(event)
                    }
                    let error: (TaskList)->Void = { [weak self] list in
                         let alert = UIAlertController(title: "Error in deleting", message: list.message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self?.present(alert, animated: true)
                        
                    }
                    RequesterURL.ask.deleteTask(id: id, toDoIfSuccess: success, toDoIfError: error)
                case .saveTask(let task):
                    guard let task = task else {return}
                    let success : (TaskDetail)->() = { [weak self] list in
                        guard let this = self else {return}
                        self?.eventHandler?(.saveTask(list.task))
                    }
                    let error: (TaskDetail)->Void = { [weak self] list in
                         let alert = UIAlertController(title: "Error in deleting", message: list.message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self?.present(alert, animated: true)
                    }
                    if task.id < 0 {
                        RequesterURL.ask.createTask(task,  toDoIfSuccess: success, toDoIfError: error)
                    } else {
                        RequesterURL.ask.updateTask(task,  toDoIfSuccess: success, toDoIfError: error)
                    }
                default:
                    self?.eventHandler?(event)
                }
                
            }
        }
    }
    
    // MARK: -
    // MARK: Init and Deinit
    
    static public func startVC() -> TaskEditViewController {
        let contr = self.loadFromStoryboard(storyboardName: "TaskEditStoryboard")
        return contr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView?.setData(self.model.data)
    }
}
