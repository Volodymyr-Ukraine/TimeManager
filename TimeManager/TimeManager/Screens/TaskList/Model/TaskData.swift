//
//  TaskData.swift
//  TimeManager
//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import Foundation

struct TaskData {
    enum Priority: String {
        case low
        case medium
        case high
    }
    var id: Int
    var description: String
    var date: String
    var longDate: String
    var priority: Priority
}
