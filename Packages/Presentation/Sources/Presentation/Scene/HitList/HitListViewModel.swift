//
//  HitListViewModel.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import Combine
import DI
import Domain

@MainActor final class HitListViewModel: ObservableObject {
    /* State */
    @Published private(set) var hits: Loadable<[HitEntity]> = .notRequested
    /* Deps */
    @Inject(container: .usecases) private var usecase: HitUsecase

    nonisolated init() {}

    func fetch() {
        Task {
            let result = try await usecase.fetch(with: .init(page: 1))
            hits = .loaded(result.hits)
        }
    }
}
