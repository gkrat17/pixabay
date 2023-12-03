//
//  Validator.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

public protocol Validator {
    func validationError(input: String) -> String?
}
