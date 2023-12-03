//
//  HitListCoordinator.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import DI
import Domain
import UIKit

protocol HitListCoordinator {
    func start()
    func onHitEntity(entity: HitEntity)
}

final class DefaultHitListCoordinator: HitListCoordinator {
    @Inject(container: .default) private var navigationController: UINavigationController
    @Inject(container: .coordinators) private var hitDetailsCoordinator: HitDetailsCoordinator

    func start() {
        navigationController.pushViewController(HitListViewController(), animated: true)
    }

    func onHitEntity(entity: HitEntity) {
        hitDetailsCoordinator.start(with: entity)
    }
}
