//
//  Config.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import Foundation

protocol Config {
    var API_SCHEME: String { get }
    var API_HOST: String { get }
    var API_PATH: String { get }
    var API_KEY: String { get }
}

extension Bundle: Config {
    var API_SCHEME: String { object(forInfoDictionaryKey: "API_SCHEME") as! String }
    var API_HOST: String { object(forInfoDictionaryKey: "API_HOST") as! String }
    var API_PATH: String { object(forInfoDictionaryKey: "API_PATH") as! String }
    var API_KEY: String { object(forInfoDictionaryKey: "API_KEY") as! String }
}
