//
//  SwiftUIView.swift
//  TodoListView
//
//  Created by yuki noda on 2025/04/26.
//

import SwiftUI
import APIServer

struct TodoCell: View {
    @ObservedObject var viewModel: TodoCellViewModel
    
    var body: some View {
        Text(viewModel.todoName)
    }
}

#Preview {
    TodoCell(
        viewModel: TodoCellViewModel(
            todo: Todo(
                id: UUID(),
                title: "タスク1",
                expired: Date(),
                done: false
            )
        )
    )
}
