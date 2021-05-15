//
//  HomeView.swift
//  DragDrop
//
//  Created by Harshit Parikh on 25/04/21.
//

import SwiftUI

struct HomeView: View {
    // MARK:- Properties
    @StateObject var viewModel = HomeVM()
    @State private var selectedTab: Int = 0
    @State private var taskTypes: [TaskType] = [.upcoming, .inProgress, .completed]
    @State private var addNewCard: Bool = false
    private var selectedTaskType: TaskType {
        return TaskType(rawValue: selectedTab) ?? .upcoming
    }
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                VStack {
                    Picker(selection: $selectedTab, label: Text("Tasks")) {
                        Text("Upcoming").tag(0)
                        Text("In Progress").tag(1)
                        Text("Completed").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10)
                    .onChange(of: selectedTab) { tag in
                        withAnimation(.default) {
                            switch selectedTaskType {
                            case .upcoming:
                                proxy.scrollTo(tag, anchor: .leading)
                                break
                            case .inProgress:
                                proxy.scrollTo(tag, anchor: .center)
                                break
                            case .completed:
                                proxy.scrollTo(tag, anchor: .trailing)
                                break
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0 ..< taskTypes.count) { i in
                                let type = TaskType(rawValue: i)
                                VStack(alignment: .leading) {
                                    switch type {
                                    case .upcoming:
                                        TaskListView(selectedIndex: $selectedTab, array: self.$viewModel.tasksArray.upcomingArray, taskType: .upcoming, viewModel: viewModel)
                                    case .inProgress:
                                        TaskListView(selectedIndex: $selectedTab, array: self.$viewModel.tasksArray.inProgressArray, taskType: .inProgress, viewModel: viewModel)
                                    case .completed:
                                        TaskListView(selectedIndex: $selectedTab, array: self.$viewModel.tasksArray.completedArray, taskType: .completed, viewModel: viewModel)
                                    default:
                                        EmptyView()
                                    }
                                }
                                .frame(width: 300)
                                .background(type == .upcoming ? Color.pink.opacity(0.25) : (type == .inProgress ? Color.blue.opacity(0.25) : Color.green.opacity(0.25)))
                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.vertical, 10)
                    }
                    
                    Spacer()
                }
                .sheet(isPresented: $addNewCard) {
                    AddNewCardView(viewModel: self.viewModel)
                }
            }
            .navigationBarTitle(Text("Task Management"), displayMode: .large)
            .navigationBarItems(trailing: Button("Add") {
                self.addNewCard.toggle()
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
