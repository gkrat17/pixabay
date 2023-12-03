//
//  DependencyContainer.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import DI
import UIKit

extension DependencyContainer {
    static var usecases = DependencyContainer {}
    static var validators = DependencyContainer {}
}

extension DependencyContainer {
    static var viewModels = DependencyContainer {
        Dependency(instanceType: .new) { AuthViewModel() }
        Dependency(instanceType: .new) { RegistrationViewModel() }
        Dependency(instanceType: .new) { HitListViewModel() }
        Dependency(instanceType: .new) { HitDetailsViewModel() }
    }
    static var coordinators = DependencyContainer {
        Dependency { DefaultAuthCoordinator() as AuthCoordinator }
        Dependency { DefaultRegistrationCoordinator() as RegistrationCoordinator }
        Dependency { DefaultHitListCoordinator() as HitListCoordinator }
        Dependency { DefaultHitDetailsCoordinator() as HitDetailsCoordinator }
    }
    static var `default` = DependencyContainer {
        Dependency { UINavigationController() }
    }
}
