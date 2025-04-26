//
//  TodoListRepository.swift
//  TodoListView
//
//  Created by yuki noda on 2025/04/26.
//

import APIServer
import Foundation

protocol TodoListRepositoryInterface {
    func fetch(force: Bool) async throws -> [Todo]
}

final class TodoListRepository: TodoListRepositoryInterface {
    func fetch(force: Bool = true) async throws -> [Todo] {
        sleep(1)
        return [
            Todo(
                id: UUID(),
                title: "タスク1",
                expired: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                done: false
            ),
            Todo(
                id: UUID(),
                title: "タスク2",
                expired: Calendar.current.date(byAdding: .month, value: 1, to: Date())!,
                done: false
            ),
            Todo(
                id: UUID(),
                title: "タスク3",
                expired: Calendar.current.date(byAdding: .year, value: 1, to: Date())!,
                done: false
            ),
        ]
    }
}
