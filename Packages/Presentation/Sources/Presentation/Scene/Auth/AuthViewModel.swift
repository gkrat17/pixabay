//
//  AuthViewModel.swift
//
//  Created by Giorgi Kratsashvili on 12/3/23.
//

import Combine
import DI
import Domain

@MainActor final class AuthViewModel: ObservableObject {
    /* State */
    @Published var email = ""
    @Published var password = ""
    @Published private(set) var emailError = ""
    @Published private(set) var passwordError = ""
    @Published private(set) var isEnabled = false
    @Published private(set) var loading = false
    /* Deps */
    @Inject(container: .usecases) private var usecase: AuthUsecase
    @Inject(container: .validators) private var emailValidator: EmailValidator
    @Inject(container: .validators) private var passwordValidator: PasswordValidator
    @Inject(container: .coordinators) private var coordinator: AuthCoordinator
    /* Misc */
    private var cancellable: AnyCancellable?

    nonisolated init() {}
}

extension AuthViewModel {
    func configure() {
        cancellable = Publishers.CombineLatest3($email, $password, $loading)
            .sink { [weak self] email, password, loading in
                guard let self else { return }
                emailError = if email.isEmpty { "" } else { emailValidator.validationError(input: email) ?? "" }
                passwordError = if password.isEmpty { "" } else { passwordValidator.validationError(input: password) ?? "" }
                isEnabled = !loading &&
                            !email.isEmpty && !password.isEmpty &&
                            emailError.isEmpty && passwordError.isEmpty
            }
    }

    func auth() {
        guard !loading else { return }
        loading = true
        Task {
            do {
                try await usecase.auth(with: .init(email: email, password: password))
                coordinator.onAuthSuccess()
            } catch {
                // handle error
            }
            loading = false
        }
    }

    func register() {
        coordinator.onRegister()
    }
}
