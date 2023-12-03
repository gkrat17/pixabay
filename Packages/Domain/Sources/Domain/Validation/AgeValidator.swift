//
//  AgeValidator.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

public protocol AgeValidator: Validator {}

public class DefaultAgeValidator: AgeValidator {
    public init() {}

    public func validationError(input: String) -> String? {
        guard let age = Int(input) else { return "Age should be a number" }
        if age < 18 { return "Age should be at least 18" }
        if age > 99 { return "Age should be at most 99" }
        return nil
    }
}
