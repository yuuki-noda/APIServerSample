//
//  TodoListViewModel.swift
//  TodoListView
//
//  Created by yuki noda on 2025/04/26.
//
import Foundation

final class TodoListViewModel: ObservableObject {
    @Published var todoCellViewModels: [TodoCellViewModel]
    
    init(todoCellViewModels: [TodoCellViewModel]) {
        self.todoCellViewModels = todoCellViewModels
    }
    
    var shownEmptyLabel: Bool {
        return todoCellViewModels.isEmpty
    }
}
