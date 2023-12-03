//
//  HitDetailsViewModel.swift
//
//  Created by Giorgi Kratsashvili on 12/3/23.
//

import Combine
import Domain

@MainActor final class HitDetailsViewModel: ObservableObject {
    /* State */
    @Published var entity: HitEntity?

    nonisolated init() {}
}
