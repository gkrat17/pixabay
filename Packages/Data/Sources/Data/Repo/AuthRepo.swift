//
//  AuthRepo.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import Domain

public final class DefaultAuthRepo: AuthRepo {
    public init() {}

    public func auth(with: AuthParams) async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }
}
