//
//  Coordinator.swift
//  RedditClone
//
//  Created by William Huynh on 12/22/20.
//

import Foundation

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
