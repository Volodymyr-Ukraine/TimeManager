//
//  TaskListModel.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import Foundation

class TaskListModel {
    public var data: [TaskData] = []
    
    init() {
        self.makeTestData()
    }
    
    private func makeTestData(){
        data.append(TaskData(id: 1, description: "The first description", date: "02/19/19", longDate: "Thuesday 19 Feb, 2019", priority: .low))
        data.append(TaskData(id: 2, description: "Second description", date: "02/19/19", longDate: "Thuesday 19 Feb, 2019", priority: .medium))
    }
}


