//
//  AuthRepo.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

public protocol AuthRepo {
    func auth(with: AuthParams) async throws
}
