//
//  RegistrationCoordinator.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import DI
import UIKit

protocol RegistrationCoordinator {
    func start()
    func onRegistrationSuccess()
}

final class DefaultRegistrationCoordinator: RegistrationCoordinator {
    @Inject(container: .default) private var navigationController: UINavigationController
    @Inject(container: .coordinators) private var hitListCoordinator: HitListCoordinator

    func start() {
        navigationController.pushViewController(RegistrationViewController(), animated: true)
    }

    func onRegistrationSuccess() {
        hitListCoordinator.start()
    }
}
