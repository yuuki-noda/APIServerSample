//
//  Todo.swift
//  APIServer
//
//  Created by yuki noda on 2025/04/26.
//

import Vapor

public struct Todo: Content, Sendable {
    public let id: UUID
    public let title: String
    public let expired: Date
    public let done: Bool
    
    public init(id: UUID, title: String, expired: Date, done: Bool) {
        self.id = id
        self.title = title
        self.expired = expired
        self.done = done
    }
}
