//
//  TaskView.swift
//  DragDrop
//
//  Created by Harshit Parikh on 25/04/21.
//

import SwiftUI
import MobileCoreServices

struct TaskListView: View {
    // MARK:- Properties
    @Binding var selectedIndex: Int
    @Binding var array: [TaskInfo]
    var taskType: TaskType
    var viewModel: HomeVM
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                if array.count > 0 {
                    ForEach(0 ..< array.count, id: \.self) { i in
                        TaskView(task: array[i])
                    }
                } else {
                    Text("No tasks available")
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onDrop(
            of: [kUTTypeData as String],
            delegate: TaskDropDelegate(selectedIndex: $selectedIndex, array: $array, taskType: taskType, viewModel: viewModel)
        )
    }
}

struct TaskDropDelegate: DropDelegate {
    // MARK:- Properties
    @Binding var selectedIndex: Int
    @Binding var array: [TaskInfo]
    var taskType: TaskType
    var viewModel: HomeVM
    
    // MARK:- Methods
    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [kUTTypeData as String]) else {
            return false
        }
        let items = info.itemProviders(for: [kUTTypeData as String])
        guard let item = items.first else {
            return false
        }
        item.loadDataRepresentation(forTypeIdentifier: kUTTypeData as String) { (data, error) in
            guard error == nil else {
                print("Error: ", error.debugDescription)
                return
            }
            guard let responseData = data else {
                return
            }
            do {
                var dataBlob = try PropertyListDecoder().decode(TaskInfo.self, from: responseData)
                DispatchQueue.main.async {
                    withAnimation() {
                        switch dataBlob.taskStatus {
                        case .upcoming:
                            guard let index = self.viewModel.tasksArray.upcomingArray.map({ $0.id }).firstIndex(of: dataBlob.id) else {
                                return
                            }
                            self.viewModel.tasksArray.upcomingArray.remove(at: index)
                        case .inProgress:
                            guard let index = self.viewModel.tasksArray.inProgressArray.map({ $0.id }).firstIndex(of: dataBlob.id) else {
                                return
                            }
                            self.viewModel.tasksArray.inProgressArray.remove(at: index)
                        case .completed:
                            guard let index = self.viewModel.tasksArray.completedArray.map({ $0.id }).firstIndex(of: dataBlob.id) else {
                                return
                            }
                            self.viewModel.tasksArray.completedArray.remove(at: index)
                        }
                        self.selectedIndex = taskType.rawValue
                        dataBlob.taskStatus = TaskType(rawValue: taskType.rawValue) ?? .upcoming
                        self.array.append(dataBlob)
                    }
                }
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        return true
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func dropEntered(info: DropInfo) {

    }

    func dropExited(info: DropInfo) {

    }
}
