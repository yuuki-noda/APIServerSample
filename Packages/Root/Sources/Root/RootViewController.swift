//
//  ViewController.swift
//  APISampleProject
//
//  Created by yuki noda on 2025/04/19.
//

import UIKit
import ServerView

public class RootViewController: UIViewController {
    @IBOutlet private var serverModeButton: UIButton!
    
    public static func loadXib() -> RootViewController {
        return RootViewController(nibName: nil, bundle: .module)
    }
    
    @IBAction private func didTapServerModeButton() {
        let viewController = ServerViewController.loadNib()
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
}

