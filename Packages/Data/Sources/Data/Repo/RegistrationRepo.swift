//
//  RegistrationRepo.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import Domain

public final class DefaultRegistrationRepo: RegistrationRepo {
    public init() {}

    public func register(with: RegistrationParams) async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }
}
