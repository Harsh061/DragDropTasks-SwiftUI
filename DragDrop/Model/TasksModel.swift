//
//  TasksModel.swift
//  DragDrop
//
//  Created by Harshit Parikh on 25/04/21.
//

import Foundation

enum TaskType: Int, Codable {
    case upcoming = 0
    case inProgress
    case completed
    
    var title: String {
        switch self {
        case .upcoming:
            return "Upcoming"
        case .inProgress:
            return "In Progress"
        case .completed:
            return "Completed"
        }
    }
}

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
