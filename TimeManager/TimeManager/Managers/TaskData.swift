//
//  TaskData.swift
//  TimeManager
//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import Foundation

public struct TaskData: Codable{
    public let id: Int
    public let title: String
    public let dueBy: Int
    public let priority: PriorityEnum
}

public struct TaskDetail: Codable{
    public let task: TaskData?
    public let message: String?
}
