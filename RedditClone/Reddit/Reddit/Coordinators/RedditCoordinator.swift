//
//  RedditCoordinator.swift
//  RedditClone
//
//  Created by William Huynh on 12/22/20.
//

import UIKit

class RedditCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = ViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = RedditViewModel(redditStore: RedditStore())
        navigationController.pushViewController(vc, animated: false)
    }
}
