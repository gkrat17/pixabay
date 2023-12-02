//
//  HitUsecase.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import DI

public protocol HitUsecase {
    func fetch(with: HitParamsEntity) async throws -> HitListEntity
}

public final class DefaultHitUsecase: HitUsecase {
    @Inject(container: .repos) private var repo: HitRepo

    public init() {}

    public func fetch(with params: HitParamsEntity) async throws -> HitListEntity {
        try await repo.fetch(with: params)
    }
}
