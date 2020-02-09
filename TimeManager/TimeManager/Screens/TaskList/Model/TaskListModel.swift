//
//  TaskListModel.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import Foundation

class TaskListModel {
    
    // MARK: -
    // MARK: Properties
    
    public var data: [InternalTaskData] = []
    public var sorting: SortingTypesEnum = .title
    public var direction: Bool = true
    
    public var page: Int = 0
    public var totalCounts: Int = 0
    public var limit: Int = 15
    
    // MARK: -
    // MARK: Init

    init() {
        self.makeTestData()
    }
    
    init(list: TaskList?){
        data.removeAll()
        data = list?.tasks?.map{ list in
            
            return InternalTaskData(id: list.id, title: list.title, description: list.title, date: "", longDate: "", priority: list.priority)
        } ?? []
    }
    
    // MARK: -
    // MARK: Methods
    
    public func setSeekParameters(page: Int = 1, sorting: SortingTypesEnum = .title, direction: Bool = true) {
        self.page = page
        self.sorting = sorting
        self.direction = direction
    }
    
    public func getFirstTasks(ifSuccess success:((TaskList) -> Void)?, ifError error: ((TaskList) -> Void)?) {
        self.setSeekParameters(page: 0, sorting: self.sorting, direction: self.direction)
        self.data.removeAll()
        self.getNextTask(ifSuccess: success, ifError: error)
    }
    
    public func getNextTask(ifSuccess success:((TaskList) -> Void)?, ifError error: ((TaskList) -> Void)?) {
         
        guard (self.page == 0) ||
            ((self.page * self.limit) < self.totalCounts) else {return}
        
        let successAll: ((TaskList) -> Void) = { [weak self] task in
            guard let this = self else {return}
            this.page = task.meta?.current ?? 1
            this.totalCounts = task.meta?.count ?? 15
            this.limit = task.meta?.limit ?? 1
            let internalData: [InternalTaskData]? = task.tasks?.compactMap{ task in
                let time = Date(timeIntervalSince1970: TimeInterval(task.dueBy))
                let shortFormat = DateFormatter()
                shortFormat.dateFormat = "MM" + "/" + "d" + "/" + "yy"
                let longFormat = DateFormatter()
                longFormat.dateFormat = "EEEE, d MMM, yyyy"
                return InternalTaskData(id: task.id, title: task.title, description: task.title, date: shortFormat.string(from: time), longDate: longFormat.string(from: time), priority: task.priority)
            }
            this.data.append(contentsOf: internalData ?? [])
            success?(task)
        }
        RequesterURL.ask.getTaskList(self.page + 1, sorting: self.sorting, direction: self.direction, toDoIfSuccess: successAll, toDoIfError: error)
    }
    
    private func makeTestData(){
        data.append(InternalTaskData(id: 1, title: "", description: "The first description", date: "02/19/19", longDate: "Thuesday 19 Feb, 2019", priority: .low))
        data.append(InternalTaskData(id: 2, title: "", description: "Second description", date: "02/19/19", longDate: "Thuesday 19 Feb, 2019", priority: .normal))
    }
}


