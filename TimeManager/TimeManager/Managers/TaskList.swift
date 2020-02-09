//
//  TaskList.swift
//  TimeManager
//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import Foundation

public struct TaskList: Codable {
    public let tasks: [TaskData]?
    public let meta: Meta?
    public let message: String?
}

public struct Meta: Codable {
    public let current, limit, count: Int
}
