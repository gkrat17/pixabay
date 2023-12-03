//
//  AuthParams.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

public struct AuthParams {
    public let email: String
    public let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
