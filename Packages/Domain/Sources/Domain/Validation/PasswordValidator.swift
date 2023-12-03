//
//  PasswordValidator.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

public protocol PasswordValidator: Validator {}

public class DefaultPasswordValidator: PasswordValidator {
    public init() {}

    public func validationError(input: String) -> String? {
        if input.count < 6 { return "Password length should be at least 6 symbols" }
        if input.count > 12 { return "Password length should be at most 12 symbols" }
        return nil
    }
}
