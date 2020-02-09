//
//  ScreensCoordinator.swift
//  TimeManager
//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

enum AvailableScreens {
    case login
    case taskList(TaskList?)
    case taskDetail(InternalTaskData?)
    case taskEdit(InternalTaskData?)
}


final class ScreensCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Constants
    
    public let navigationController: UINavigationController
    
    // MARK: -
    // MARK: Properties
    
    private var navigationScreens: [AvailableScreens] = []
    
    // MARK: -
    // MARK: Init and Deinit

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        self.jumpToScreen(.login)
    }
    
    // MARK: -
    // MARK: Methods
    
    private func makeLogin(){
        let contr = LoginViewController.startVC()
        self.navigationScreens.append(.login)
        self.navigationController.navigationBar.isHidden = true
        contr.model = LoginModel()
        contr.eventHandler = { [weak self] event in
            
            switch event {
            case .loginPressed(let data):
                
                let success: ((TaskList)->()) = { [weak self] list in
                    self?.jumpToScreen(.taskList(list))
                }
                RequesterURL.ask.getTaskList(1, sorting: .title, direction: true, toDoIfSuccess: success, toDoIfError: nil)
            }
        }
        self.navigationController.pushViewController(contr, animated: true)
    }
    
    private func makeTaskList(_ list: TaskList?){
        let contr = TaskListViewController.startVC()
        self.navigationScreens.append(.taskList(list))
        contr.model = TaskListModel(list: list)
        contr.model.setSeekParameters(page: 1, sorting: .title, direction: true)
        contr.eventHandler = { [weak self] event in
            
            switch event {
            case .cellInfo(let data):
                
                print(data)
                self?.jumpToScreen(.taskDetail(data))
            case .sortPressed:
                self?.jumpToScreen(.login)
            case .addTask:
                self?.jumpToScreen(.taskEdit(nil))
            }
            
        }
        self.navigationController.pushViewController(contr, animated: true)
    }
    
    private func makeTaskDetail(_ data: InternalTaskData?) {
        let contr = TaskDetailViewController.startVC()
        self.navigationScreens.append(.taskDetail(data))
        contr.model.data = data
        contr.eventHandler = { [weak self] event in
            switch event {
            case .backPressed:
                self?.navigationScreens = self?.navigationScreens.dropLast() ?? []
                self?.navigationController.popViewController(animated: true)
            case .editPressed(let data):
                self?.jumpToScreen(.taskEdit(data))
            case .deleteTask(let data):
                self?.jumpToScreen(.taskList(nil))
            }
        }
        self.navigationController.pushViewController(contr, animated: true)
    }
    
    private func makeTaskEdit(_ data: InternalTaskData?) {
        let contr = TaskEditViewController.startVC()
        self.navigationScreens.append(.taskEdit(data))
        contr.model = TaskEditModel()
        contr.model.data = data
        contr.eventHandler = {[weak self] task in
            guard let this = self else{return}
            switch task {
            case .back:
                self?.navigationScreens = self?.navigationScreens.dropLast() ?? []
                self?.navigationController.popViewController(animated: true)
            case .deleteTask(let id):
                self?.jumpToScreen(.taskList(nil))
            case .saveTask:
                self?.jumpToScreen(.taskList(nil))
            }
        }
        self.navigationController.pushViewController(contr, animated: true)
    }
}

// MARK: -
// MARK: Extensions

extension ScreensCoordinator {
    public func jumpToScreen(_ jumpTo: AvailableScreens) {
        switch jumpTo {
        case .login:
            self.makeLogin()
        case .taskList(let list):
            self.makeTaskList(list)
        case .taskDetail(let data):
            self.makeTaskDetail(data)
        case .taskEdit(let data):
            self.makeTaskEdit(data)
        }
    }
}
