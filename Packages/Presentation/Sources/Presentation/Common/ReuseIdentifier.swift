//
//  ReuseIdentifier.swift
//
//  Created by Giorgi Kratsashvili on 12/3/23.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String { .init(describing: Self.self) }
}
