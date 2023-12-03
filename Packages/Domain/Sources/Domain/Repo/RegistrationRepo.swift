//
//  RegistrationRepo.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

public protocol RegistrationRepo {
    func register(with: RegistrationParams) async throws
}
