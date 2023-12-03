//
//  AuthUsecase.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import DI

public protocol AuthUsecase {
    func auth(with: AuthParams) async throws
}

public final class DefaultAuthUsecase: AuthUsecase {
    @Inject(container: .repos) private var repo: AuthRepo

    public init() {}

    public func auth(with params: AuthParams) async throws {
        try await repo.auth(with: params)
    }
}
