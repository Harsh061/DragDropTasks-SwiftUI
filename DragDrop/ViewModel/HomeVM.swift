//
//  HomeVM.swift
//  DragDrop
//
//  Created by Harshit Parikh on 25/04/21.
//

import Foundation

class HomeVM: ObservableObject {
    // MARK:- Properties
    @Published var tasksArray: TasksModel
    
    // MARK:- Methods
    init() {
        self.tasksArray = TasksModel(upcomingArray: [TaskInfo(id: 1, title: "Upcoming One", description: "This is first task in upcoming list.", taskStatus: .upcoming), TaskInfo(id: 2, title: "Upcoming Two", description: "This is second task in upcoming list.", taskStatus: .upcoming), TaskInfo(id: 3, title: "Upcoming Three", description: "This is third task in upcoming list.", taskStatus: .upcoming)], inProgressArray: [TaskInfo(id: 4, title: "In Progress One", description: "This is first task in, In Progress list.", taskStatus: .inProgress), TaskInfo(id: 5, title: "In Progress Two", description: "This is second task in, In Progress list.", taskStatus: .inProgress)], completedArray: [TaskInfo(id: 6, title: "Completed One", description: "This is first task in completed list.", taskStatus: .completed)])
    }
}
