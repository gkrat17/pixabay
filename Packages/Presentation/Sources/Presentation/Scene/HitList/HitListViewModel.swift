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
    @Published private(set) var latestHitPage: Loadable<[HitEntity]> = .notRequested
    private var allHits = [HitEntity]()
    private var nextPageIndex = 1
    /* Deps */
    @Inject(container: .usecases) private var usecase: HitUsecase
    @Inject(container: .coordinators) private var coordinator: HitListCoordinator

    nonisolated init() {}
}

extension HitListViewModel {
    func viewDidLoad() {
        fetchNextPage()
    }

    func cellWillDisplay(at index: Int) {
        if index == allHits.count - 1 {
            fetchNextPage()
        }
    }

    func didSelectItemAt(at index: Int) {
        guard index < allHits.count else { return }
        let entity = allHits[index]
        coordinator.onHitEntity(entity: entity)
    }
}

fileprivate extension HitListViewModel {
    func fetchNextPage() {
        if case .isLoading = latestHitPage { return }
        latestHitPage = .isLoading
        Task {
            do {
                let result = try await usecase.fetch(with: .init(page: nextPageIndex))
                nextPageIndex += 1
                allHits.append(contentsOf: result.hits)
                latestHitPage = .loaded(result.hits)
            } catch {
                latestHitPage = .failed(error)
            }
        }
    }
}
