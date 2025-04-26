//
//  TodoListViewController.swift
//  TodoListView
//
//  Created by yuki noda on 2025/04/26.
//

import UIKit
import SwiftUI
import Combine

@MainActor
protocol TodoListViewInput: AnyObject {
    func update()
}

final public class TodoListViewController: UIViewController {
    var presenter: TodoListPresenterInput!
    private var cancellables: [AnyCancellable] = []
    
    private let activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .white
        activityView.backgroundColor = .lightGray
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "No todo."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo List"
        view.backgroundColor = .systemGroupedBackground
        
        let viewController = UIHostingController(rootView: TodoListView(viewModel: presenter.viewModel))
        addChild(viewController)
        view.addSubview(viewController.view)
        view.addSubview(emptyLabel)
        view.addSubview(activityView)
        
        viewController.didMove(toParent: self)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyLabel.topAnchor.constraint(equalTo: view.topAnchor),
            emptyLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            emptyLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            emptyLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityView.topAnchor.constraint(equalTo: view.topAnchor),
            activityView.leftAnchor.constraint(equalTo: view.leftAnchor),
            activityView.rightAnchor.constraint(equalTo: view.rightAnchor),
            activityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(didTapSettingButton)
        )
        
        presenter.isLoadingPublisher.receive(on: DispatchQueue.main).sink { isLoading in
            if isLoading {
                self.activityView.startAnimating()
            } else {
                self.activityView.stopAnimating()
            }
            self.activityView.isHidden = !isLoading
        }.store(in: &cancellables)
        
        presenter.viewDidLoad()
    }
    
    @objc
    private func didTapSettingButton() {
        print("[APIClient] \(#file) - \(#function)")
    }
}

extension TodoListViewController: TodoListViewInput {
    public func update() {
        emptyLabel.isHidden = !presenter.viewModel.shownEmptyLabel
    }
}
