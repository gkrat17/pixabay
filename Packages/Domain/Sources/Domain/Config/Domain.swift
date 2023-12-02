//
//  Domain.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import DI

public enum Domain {
    public static func configure(repos: DependencyContainer) {
        DependencyContainer.repos = repos
    }
}
