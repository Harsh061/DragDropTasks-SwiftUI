//
//  AddNewCardView.swift
//  DragDrop
//
//  Created by Harshit Parikh on 05/05/21.
//

import SwiftUI

struct AddNewCardView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    @ObservedObject var viewModel: HomeVM
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Task Name")
                        .font(.headline)
                    
                    TextField("", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .cornerRadius(4)
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Task Description")
                        .font(.headline)
                    
                    TextEditor(text: $description)
                        .foregroundColor(.primary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .cornerRadius(4)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.addNewTask()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add Task")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    
                    Spacer()
                }
                
                
            }
            .padding()
        }
        .background(Color.white.opacity(0.5))
    }
    
    func addNewTask() {
        self.viewModel.taskNumber += 1
        let newTaskNumber = self.viewModel.taskNumber
        
        let task = TaskInfo(id: newTaskNumber, title: self.name, description: self.description, taskStatus: .upcoming)
        self.viewModel.tasksArray.upcomingArray.append(task)
    }
}
