//
//  TaskListViewController.swift
//  TimeManager
//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

enum TaskListEvents{
    case sortPressed
    case cellInfo(InternalTaskData?)
    case addTask
}

class TaskListViewController: RootViewController, StoryboardLoadable, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: -
    // MARK: Constants
    
    private let cellName: String = "task"
    
    // MARK: -
    // MARK: Properties
    
    private var mainView: TaskListMainView? {
        return self.view as? TaskListMainView
    }
    private var table: UITableView? {
        return self.mainView?.taskTable
    }
    public var eventHandler: ((TaskListEvents)->())? {
        didSet{
            self.mainView?.eventHandler = self.eventHandler
        }
    }
    public var model: TaskListModel = TaskListModel()

    // MARK: -
    // MARK: Init and Deinit
    
    static public func startVC() -> TaskListViewController {
        let contr = self.loadFromStoryboard(storyboardName: "TaskListStoryboard")
        return contr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table?.register(UINib(nibName: "TaskListTableViewCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: cellName)
        self.table?.delegate = self
        self.table?.dataSource = self
        let success: (TaskList)->() = { [weak self] list in
            self?.table?.reloadData()
        }
        let error: (TaskList)->() = { [weak self] list in
            guard let this = self else {return}
            
            let alert = UIAlertController(title: "Error in the result", message: list.message ?? "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            this.present(alert, animated: true)
        }
        self.model.getFirstTasks(ifSuccess: success, ifError: error)
    }
    
    // MARK: -
    // MARK: TableView Delegate and Datasource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? TaskListTableViewCell,
            let cellData = self.model.data.dropFirst(indexPath.row).first else {
            return UITableViewCell()
        }
        cell.setData(cellData)
        cell.eventHandler = { [weak self] event in
            self?.eventHandler?(.cellInfo(event))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (self.model.data.count - indexPath.row) == 10 {
            let success: (TaskList)->() = {[weak self] list in
                self?.table?.reloadData()
            }
            self.model.getNextTask(ifSuccess: success, ifError: nil)
        }
    }
}
