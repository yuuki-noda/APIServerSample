//
//  TodoListPresenter
//  TodoListView
//
//  Created by yuki.noda on 2025/04/26.
//

import Foundation

@MainActor
protocol TodoListPresenterInput: AnyObject {
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    var viewModel: TodoListViewModel { get }
    
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
}

final class TodoListPresenter {
    weak var view: TodoListViewInput?
    let interactor: TodoListInteractorInput
    let router: TodoListRouterInput
    let viewModel = TodoListViewModel(todoCellViewModels: [])
    
    @Published var isLoading = false

    init(view: TodoListViewInput, interactor: TodoListInteractorInput, router: TodoListRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    @MainActor
    private func fetch(force: Bool = true) {
        Task { [weak view] in
            isLoading = true
            do {
                let viewModels = try await interactor.fetch(force: force)
                viewModel.todoCellViewModels = viewModels
                view?.update()
            }
            catch {
                // TODO: handle error
            }
            isLoading = false
        }
    }
}

extension TodoListPresenter: TodoListPresenterInput {
    var isLoadingPublisher: Published<Bool>.Publisher {
        return $isLoading
    }
    
    func viewDidLoad() {
        fetch()
    }
}

extension TodoListPresenter: TodoListInteractorOutput {}
