//
//  TaskView.swift
//  DragDrop
//
//  Created by Harshit Parikh on 26/04/21.
//

import SwiftUI
import MobileCoreServices

struct TaskView: View {
    // MARK:- Properties
    @State private var flipped = false
    @State private var animate3d = false
    var task: TaskInfo
    
    var body: some View {
        ZStack {
            // Front View
            frontView
            .opacity(flipped ? 0.0 : 1.0)
            
            // Back View
            backView
            .opacity(flipped ? 1.0 : 0.0)
        }
        
    }
    
    var frontView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Task Id: ")
                    .font(.headline)
                Text("\(task.id)")
                    .font(.subheadline)

                Text("Name")
                    .font(.headline)
                Text(task.title)
                    .font(.subheadline)

                Text("Status")
                    .font(.headline)
                Text(task.taskStatus.title)
                    .font(.subheadline)
            }
            .padding()

            Spacer()
        }
        .frame(height: 180)
        .background(task.taskStatus == .upcoming ? Color.pink.opacity(0.5) : (task.taskStatus == .inProgress ? Color.blue.opacity(0.5) : Color.green.opacity(0.5)))
        .cornerRadius(20)
        .onDrag {
            let itemProvider = convertModelToData(model: task)!
            return itemProvider
        }
        .modifier(FlipEffect(flipped: $flipped, angle: animate3d ? 180 : 0, axis: (x: 1, y: 0)))
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.8)) {
                self.animate3d.toggle()
            }
        }
    }
    
    var backView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Task Description: ")
                    .font(.headline)
                Text("\(task.description)")
                    .font(.subheadline)
                
                Spacer()
            }
            .padding()

            Spacer()
        }
        .frame(height: 180)
        .background(task.taskStatus == .upcoming ? Color.pink.opacity(0.5) : (task.taskStatus == .inProgress ? Color.blue.opacity(0.5) : Color.green.opacity(0.5)))
        .cornerRadius(20)
        .onDrag {
            let itemProvider = convertModelToData(model: task)!
            return itemProvider
        }
        .modifier(FlipEffect(flipped: $flipped, angle: animate3d ? 180 : 0, axis: (x: 1, y: 0)))
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.8)) {
                self.animate3d.toggle()
            }
        }
    }
    
    // MARK:- Methods
    private func convertModelToData(model: TaskInfo) -> NSItemProvider? {
        do {
            let dataBlob = try PropertyListEncoder().encode(model)
            return NSItemProvider(item: dataBlob as NSData, typeIdentifier: kUTTypeData as String)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
    
}
