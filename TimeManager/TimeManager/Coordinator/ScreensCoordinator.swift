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
    case taskList
    case taskDetail(TaskData?)
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
                print("ScreensCoordinator catched \(event) with data \(data)")
            }
            self?.jumpToScreen(.taskList)
        }
        self.navigationController.pushViewController(contr, animated: true)
    }
    
    private func makeTaskList(){
        let contr = TaskListViewController.startVC()
        self.navigationScreens.append(.taskList)
        contr.model = TaskListModel()
        contr.eventHandler = { [weak self] event in
            
            switch event {
            case .cellInfo(let data):
                
                print(data)
                self?.jumpToScreen(.taskDetail(data))
            case .sortPressed:
                self?.jumpToScreen(.login)
            case .addTask:
                print("\(event)")
            }
            
        }
        self.navigationController.pushViewController(contr, animated: true)
    }
    
    private func makeTaskDetail(_ data: TaskData?) {
        let contr = TaskDetailViewController.startVC()
        self.navigationScreens.append(.taskDetail(data))
        contr.model.data = data
        contr.eventHandler = { [weak self] event in
            switch event {
            case .backPressed:
                self?.navigationScreens = self?.navigationScreens.dropLast() ?? []
                self?.navigationController.popViewController(animated: true)
            default:
                print("TODO : handle event \(event) in \(Self.self)")
                self?.makeTaskEdit(nil)
            }
        }
        self.navigationController.pushViewController(contr, animated: true)
    }
    
    private func makeTaskEdit(_ data: TaskData?) {
        let contr = TaskEditViewController.startVC()
        self.navigationController.pushViewController(contr, animated: true)
    }
}

extension ScreensCoordinator {
    public func jumpToScreen(_ jumpTo: AvailableScreens) {
        switch jumpTo {
        case .login:
            self.makeLogin()
        case .taskList:
            self.makeTaskList()
        case .taskDetail(let data):
            self.makeTaskDetail(data)
        }
    }
}
