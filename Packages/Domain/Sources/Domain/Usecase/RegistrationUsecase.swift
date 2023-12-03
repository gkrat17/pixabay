//
//  RegistrationUsecase.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import DI

public protocol RegistrationUsecase {
    func register(with: RegistrationParams) async throws
}

public final class DefaultRegistrationUsecase: RegistrationUsecase {
    @Inject(container: .repos) private var repo: RegistrationRepo

    public init() {}

    public func register(with params: RegistrationParams) async throws {
        try await repo.register(with: params)
    }
}
