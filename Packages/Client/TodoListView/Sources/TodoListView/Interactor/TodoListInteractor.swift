//
//  TodoListInteractor
//  TodoListView
//
//  Created by yuki.noda on 2025/04/26.
//

import Foundation
import APIServer

protocol TodoListInteractorInput: AnyObject {
    // MARK: Methods called from presenter

    func fetch(force: Bool) async throws -> [TodoCellViewModel]
}

protocol TodoListInteractorOutput: AnyObject {
    // MARK: Callback methods for presenter
}

final class TodoListInteractor {
    // MARK: VIPER property
    weak var presenter: TodoListInteractorOutput!

    private var repository: TodoListRepositoryInterface

    // MARK: Stored instance properties
    
    // MARK: Computed instance properties

    // MARK: Initializer
    init(repository: TodoListRepositoryInterface) {
        self.repository = repository
    }

    // MARK: Other private methods
}

extension TodoListInteractor: TodoListInteractorInput {
    func fetch(force: Bool = true) async throws -> [TodoCellViewModel] {
        let todos = try await repository.fetch(force: force)
        return todos.map({ TodoCellViewModel(todo: $0) })
    }
}
