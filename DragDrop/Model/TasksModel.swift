//
//  TasksModel.swift
//  DragDrop
//
//  Created by Harshit Parikh on 25/04/21.
//

import Foundation

struct TasksModel {
    var upcomingArray: [TaskInfo]
    var inProgressArray: [TaskInfo]
    var completedArray: [TaskInfo]
}

struct TaskInfo: Codable {
    var id: Int
    var title: String
    var description: String
    var taskStatus: TaskType
}
