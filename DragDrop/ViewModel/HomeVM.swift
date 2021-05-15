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
    var taskNumber: Int = 0
    
    // MARK:- Methods
    init() {
        self.tasksArray = TasksModel(upcomingArray: [TaskInfo(id: 1, title: "Meeting with Paul", description: "Meeting with Paul from XYZ \nDate: 17th May 2021 \nTime: 10 - 10:30 IST", taskStatus: .upcoming)], inProgressArray: [TaskInfo(id: 2, title: "Create task management app.", description: "Demonstrate Drag and Drop in SwiftUI. \nCreate new task functionality. \nDelete new task functionality. \nBasic animations.", taskStatus: .inProgress)], completedArray: [TaskInfo(id: 3, title: "Learn animations in SwiftUI", description: "Learn animations and transitions for next article in SwiftUI.", taskStatus: .completed)])
        
        let upcomingCount = self.tasksArray.upcomingArray.count
        let inProgressCount = self.tasksArray.inProgressArray.count
        let completedCount = self.tasksArray.completedArray.count
        
        self.taskNumber = upcomingCount + inProgressCount + completedCount
    }
}
