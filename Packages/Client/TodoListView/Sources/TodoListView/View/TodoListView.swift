// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import APIServer

struct TodoListView: View {
    @ObservedObject var viewModel: TodoListViewModel
    
    var body: some View {
        List(viewModel.todoCellViewModels) { todo in
            TodoCell(viewModel: todo)
        }
    }
}

#Preview {
    let viewModel = TodoListViewModel(
        todoCellViewModels: [
            TodoCellViewModel(
                todo: Todo(
                    id: UUID(),
                    title: "タスク1",
                    expired: Date(),
                    done: false
                )
            ),
            TodoCellViewModel(
                todo: Todo(
                    id: UUID(),
                    title: "タスク2",
                    expired: Date(),
                    done: false
                )
            ),
            TodoCellViewModel(
                todo: Todo(
                    id: UUID(),
                    title: "タスク3",
                    expired: Date(),
                    done: false
                )
            )
        ]
    )
    TodoListView(viewModel: viewModel)
}

