//
//  ErrorLabel.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import UIKit

extension UILabel {
    static var error: UILabel {
        let label = UILabel()
        label.textColor = .red
        return label
    }
}
