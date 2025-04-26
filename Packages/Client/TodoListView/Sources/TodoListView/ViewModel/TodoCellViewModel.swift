//
//  TodoViewModel.swift
//  TodoListView
//
//  Created by yuki noda on 2025/04/26.
//

import Foundation
import APIServer

final class TodoCellViewModel: ObservableObject, Identifiable {
    @Published var todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
    }
    
    var todoName: String {
        todo.title
    }
}
