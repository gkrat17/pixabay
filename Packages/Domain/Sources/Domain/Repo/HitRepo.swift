//
//  HitRepo.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

public protocol HitRepo {
    func fetch(with: HitParamsEntity) async throws -> HitListEntity
}
