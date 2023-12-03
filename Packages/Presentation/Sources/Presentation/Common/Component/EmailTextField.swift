//
//  EmailTextField.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import UIKit

extension UITextField {
    static var email: UITextField {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        return textField
    }
}
