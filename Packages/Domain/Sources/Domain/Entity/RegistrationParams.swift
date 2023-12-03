//
//  RegistrationParams.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

public struct RegistrationParams {
    public let email: String
    public let password: String
    public let age: String

    public init(email: String, password: String, age: String) {
        self.email = email
        self.password = password
        self.age = age
    }
}
