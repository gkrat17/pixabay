//
//  DependencyContainer.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import DI
import Domain
import Foundation
import Network

extension DependencyContainer {
    static var `default` = DependencyContainer {
        Dependency { Bundle.main as Config }
        Dependency { DefaultDataTransferService() as DataTransferService }
        Dependency(instanceType: .new) { DefaultRequestBuilder() as RequestBuilder }
    }
}
