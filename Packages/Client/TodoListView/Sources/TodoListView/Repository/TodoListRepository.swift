//
//  TodoListRepository.swift
//  TodoListView
//
//  Created by yuki noda on 2025/04/26.
//

import APIServer

protocol TodoListRepositoryInterface {
    func fetch(force: Bool) async throws -> [Todo]
}

final class TodoListRepository: TodoListRepositoryInterface {
    func fetch(force: Bool = true) async throws -> [Todo] {
        return []
    }
}
