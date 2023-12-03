//
//  Regex.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import Foundation

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(lhs.startIndex..<lhs.endIndex, in: lhs)
        return regex.firstMatch(in: lhs, range: range) != nil
    }
}
