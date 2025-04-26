//
//  TodoListRouter.swift
//  TodoListView
//
//  Created by yuki noda on 2025/04/26.
//


import UIKit

@MainActor
protocol TodoListRouterInput: AnyObject {
    // MARK: View transitions
}

@MainActor
final public class TodoListRouter {
    // MARK: VIPER property
    private unowned let viewController: TodoListViewController

    init(viewController: TodoListViewController) {
        self.viewController = viewController
    }

    public static func assembleModule() -> TodoListViewController {
        let view = TodoListViewController()
        let repository = TodoListRepository()
        let interactor = TodoListInteractor(repository: repository)
        let router = TodoListRouter(viewController: view)
        let presenter = TodoListPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension TodoListRouter: TodoListRouterInput {}
