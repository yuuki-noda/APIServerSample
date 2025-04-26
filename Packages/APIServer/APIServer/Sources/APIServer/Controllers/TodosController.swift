//
//  TODO.swift
//  APIServer
//
//  Created by yuki noda on 2025/04/26.
//

import Vapor

struct TodosController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("todos")
        todos.get(use: index)
    }
    
    func index(req: Request) async throws -> [Todo] {
        return [
            Todo(id: UUID(), title: "タスク1", expired: Date(), done: false)
        ]
    }
}
