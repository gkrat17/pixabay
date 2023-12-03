//
//  AuthCoordinator.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import DI
import UIKit

protocol AuthCoordinator {
    func start()
    func onRegister()
    func onAuthSuccess()
}

final class DefaultAuthCoordinator: AuthCoordinator {
    @Inject(container: .default) private var navigationController: UINavigationController
    @Inject(container: .coordinators) private var registrationCoordinator: RegistrationCoordinator
    @Inject(container: .coordinators) private var hitListCoordinator: HitListCoordinator

    func start() {
        navigationController.pushViewController(AuthViewController(), animated: true)
    }

    func onRegister() {
        registrationCoordinator.start()
    }

    func onAuthSuccess() {
        hitListCoordinator.start()
    }
}
