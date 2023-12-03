//
//  Button.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import UIKit

extension UIButton {
    static func button(title: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}
