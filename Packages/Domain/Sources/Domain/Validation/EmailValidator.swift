//
//  EmailValidator.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

public protocol EmailValidator: Validator {}

public class DefaultEmailValidator: EmailValidator {
    public init() {}

    public func validationError(input: String) -> String? {
        let isValid = input ~= "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return if isValid { nil } else { "Invalid email" }
    }
}
