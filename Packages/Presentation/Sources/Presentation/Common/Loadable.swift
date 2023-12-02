//
//  Loadable.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

enum Loadable<T> {
    case notRequested
    case isLoading
    case loaded(T)
    case failed(Error)
}
