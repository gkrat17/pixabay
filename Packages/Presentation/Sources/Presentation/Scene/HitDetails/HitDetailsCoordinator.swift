//
//  HitDetailsCoordinator.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import DI
import Domain
import UIKit

protocol HitDetailsCoordinator {
    func start(with entity: HitEntity)
}

final class DefaultHitDetailsCoordinator: HitDetailsCoordinator {
    @Inject(container: .default) private var navigationController: UINavigationController

    func start(with entity: HitEntity) {
        let viewController = HitDetailsViewController()
        viewController.configure(with: entity)
        navigationController.pushViewController(viewController, animated: true)
    }
}
