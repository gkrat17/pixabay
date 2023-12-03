//
//  PasswordTextField.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import UIKit

extension UITextField {
    static var password: UITextField {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        return textField
    }
}
