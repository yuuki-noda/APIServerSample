//
//  APIServer.swift
//  APIServer
//
//  Created by yuki noda on 2025/04/11.
//

import Vapor

public struct APIServer: Sendable {
    // MARK: Lifecycle

    public init() async throws {
        app = try await Application.make(.development)
        app.http.server.configuration.hostname = "0.0.0.0"
        app.http.server.configuration.port = 8080
        app.routes.defaultMaxBodySize = "50MB"
    }

    // MARK: Internal
    
    public let app: Application

    public func routing() throws {
        try app.register(collection: TodosController())
    }
    
    public func start() async throws {
        try await app.startup()
    }
    
    public func shutdown() {
        app.shutdown()
    }
}
