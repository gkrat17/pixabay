//
//  DependencyContainer.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import DI

extension DependencyContainer {
    static var usecases = DependencyContainer {}
    static var validators = DependencyContainer {}
}

extension DependencyContainer {
    static var viewModels = DependencyContainer {
        Dependency(instanceType: .new) { AuthViewModel() }
        Dependency(instanceType: .new) { HitListViewModel() }
        Dependency(instanceType: .new) { HitDetailsViewModel() }
    }
}
