//
//  RegistrationViewModel.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import Combine
import DI
import Domain

@MainActor final class RegistrationViewModel: ObservableObject {
    /* State */
    @Published var email = ""
    @Published var password = ""
    @Published var age = ""
    @Published private(set) var emailError = ""
    @Published private(set) var passwordError = ""
    @Published private(set) var ageError = ""
    @Published private(set) var isEnabled = false
    @Published private(set) var loading = false
    /* Deps */
    @Inject(container: .validators) private var emailValidator: EmailValidator
    @Inject(container: .validators) private var passwordValidator: PasswordValidator
    @Inject(container: .validators) private var ageValidator: AgeValidator
    @Inject(container: .usecases) private var usecase: RegistrationUsecase
    /* Misc */
    private var cancellable: AnyCancellable?

    nonisolated init() {}
}

extension RegistrationViewModel {
    func configure() {
        cancellable = Publishers.CombineLatest4($email, $password, $age, $loading)
            .sink { [weak self] email, password, age, loading in
                guard let self else { return }
                emailError = if email.isEmpty { "" } else { emailValidator.validationError(input: email) ?? "" }
                passwordError = if password.isEmpty { "" } else { passwordValidator.validationError(input: password) ?? "" }
                ageError = if password.isEmpty { "" } else { ageValidator.validationError(input: age) ?? "" }
                isEnabled = !loading &&
                            !email.isEmpty && !password.isEmpty && !age.isEmpty &&
                            emailError.isEmpty && passwordError.isEmpty && ageError.isEmpty
            }
    }

    func register() {
        guard !loading else { return }
        loading = true
        Task {
            do {
                try await usecase.register(with: .init(email: email, password: password, age: age))
            } catch {
                // handle error
            }
            loading = false
        }
    }
}
