//
//  Presentation.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import DI
import UIKit

public enum Presentation {
    public static func configure(usecases: DependencyContainer) {
        DependencyContainer.usecases = usecases
    }

    public static func configure(validators: DependencyContainer) {
        DependencyContainer.validators = validators
    }

    public static func initial() -> UIViewController {
        UINavigationController(rootViewController: AuthViewController())
    }
}
