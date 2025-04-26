//
//  TodoViewModel.swift
//  TodoListView
//
//  Created by yuki noda on 2025/04/26.
//

import Foundation
import APIServer

final class TodoCellViewModel: ObservableObject, Identifiable, Sendable {
    let todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
    }
    
    var todoName: String {
        todo.title
    }
}
