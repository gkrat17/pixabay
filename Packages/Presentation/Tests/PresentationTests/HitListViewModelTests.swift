//
//  HitListViewModelTests.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import Combine
import DI
import Domain
import XCTest
@testable import Presentation

@MainActor final class HitListViewModelTests: XCTestCase {
    private var sut: HitListViewModel!
    private var hitUsecaseSpy: HitUsecaseSpy!
    private var hitListCoordinatorSpy: HitListCoordinatorSpy!
    private var cancellable: AnyCancellable?

    override func setUp() {
        super.setUp()

        hitUsecaseSpy = .init()
        DependencyContainer.usecases = .init {
            Dependency { self.hitUsecaseSpy as HitUsecase }
        }

        hitListCoordinatorSpy = .init()
        DependencyContainer.coordinators = .init {
            Dependency { self.hitListCoordinatorSpy as HitListCoordinator }
        }

        sut = .init()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellable = nil

        DependencyContainer.usecases = .init {}
        DependencyContainer.coordinators = .init {}

        hitUsecaseSpy = nil
        hitListCoordinatorSpy = nil
    }

    func testViewDidLoad() async {
        // given
        let ex = expectation(description: "")
        cancellable = hitUsecaseSpy.fetchPublisher
            .sink { _ in ex.fulfill() }

        // when
        sut.viewDidLoad()

        // than
        await fulfillment(of: [ex], timeout: 0.1)
    }

    func testCellWillDisplay() async throws {
        // given
        let ex = expectation(description: "")
        ex.expectedFulfillmentCount = 2
        cancellable = hitUsecaseSpy.fetchPublisher
            .sink { _ in ex.fulfill() }

        sut.viewDidLoad()
        try await Task.sleep(nanoseconds: 1000)

        // when
        sut.cellWillDisplay(at: .zero)

        // than
        await fulfillment(of: [ex], timeout: 0.1)
    }

    func testDidSelectItemAt() async throws {
        // given
        let ex = expectation(description: "")
        cancellable = hitListCoordinatorSpy.onHitEntityPublisher
            .sink { _ in ex.fulfill() }

        sut.viewDidLoad()
        try await Task.sleep(nanoseconds: 1000)

        // when
        sut.didSelectItemAt(at: .zero)

        // than
        await fulfillment(of: [ex], timeout: 0.1)
    }
}

fileprivate final class HitUsecaseSpy: HitUsecase {
    var fetchPublisher = PassthroughSubject<HitParamsEntity, Never>()

    func fetch(with params: HitParamsEntity) -> HitListEntity {
        fetchPublisher.send(params)
        return .init(hits: [
            .init(id: .init(),
                  type: .init(),
                  tags: .init(),
                  previewURL: .init(),
                  largeImageURL: .init(),
                  imageSize: .init(),
                  views: .init(),
                  downloads: .init(),
                  collections: .init(),
                  likes: .init(),
                  comments: .init(),
                  user: .init())
        ])
    }
}

fileprivate final class HitListCoordinatorSpy: HitListCoordinator {
    var startPublisher = PassthroughSubject<Void, Never>()
    var onHitEntityPublisher = PassthroughSubject<HitEntity, Never>()

    func start() {
        startPublisher.send(())
    }

    func onHitEntity(entity: HitEntity) {
        onHitEntityPublisher.send(entity)
    }
}
