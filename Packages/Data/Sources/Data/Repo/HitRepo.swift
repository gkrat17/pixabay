//
//  HitRepo.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import DI
import Domain
import Foundation
import Network

public final class DefaultHitRepo: HitRepo {
    @Inject(container: .default, storage: false) private var builder: RequestBuilder
    @Inject(container: .default) private var service: DataTransferService

    public init() {}

    public func fetch(page: Int) async throws -> HitListEntity {
        let request: URLRequest = try builder
            .configure()
            .append(query: ("page", "\(page)"))
            .build()
        return try await service.request(with: request)
    }
}
