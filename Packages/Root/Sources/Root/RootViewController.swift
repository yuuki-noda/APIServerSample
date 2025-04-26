//
//  ViewController.swift
//  APISampleProject
//
//  Created by yuki noda on 2025/04/19.
//

import UIKit
import ServerView
import TodoListView

public class RootViewController: UIViewController {
    public static func loadXib() -> RootViewController {
        return RootViewController(nibName: nil, bundle: .module)
    }
    
    @IBAction private func didTapServerModeButton() {
        let viewController = ServerViewController.loadNib()
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    @IBAction private func didTapClientModeButton() {
        let viewController = TodoListRouter.assembleModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true)
    }
}

