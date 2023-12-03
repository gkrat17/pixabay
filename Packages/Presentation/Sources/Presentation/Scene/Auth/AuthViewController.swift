//
//  AuthViewController.swift
//
//  Created by Giorgi Kratsashvili on 12/3/23.
//

import DI
import UIKit
import Combine

final class AuthViewController: UIViewController {
    @Inject(container: .viewModels) private var viewModel: AuthViewModel

    private let emailTextField: UITextField = .email
    private let passwordTextField: UITextField = .password

    private let emailErrorLabel: UILabel = .error
    private let passwordErrorLabel: UILabel = .error

    private lazy var authButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Auth", for: .normal)
        button.addTarget(self, action: #selector(authTapped), for: .touchUpInside)
        return button
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return button
    }()

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

fileprivate extension AuthViewController {
    func configure() {
        viewModel.configure()
        configureNavigation()
        configureHierarchy()
        configureDelegates()
        bind()
    }

    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Login"
    }

    private func configureHierarchy() {
        view.backgroundColor = .systemBackground
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            emailErrorLabel,
            passwordTextField,
            passwordErrorLabel,
            authButton,
            registerButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    func bind() {
        viewModel.$emailError
            .sink { [weak self] in
                self?.emailErrorLabel.text = $0
            }.store(in: &cancellables)

        viewModel.$passwordError
            .sink { [weak self] in
                self?.passwordErrorLabel.text = $0
            }.store(in: &cancellables)

        viewModel.$isEnabled
            .sink { [weak self] in
                self?.authButton.isEnabled = $0
            }.store(in: &cancellables)
    }

    func configureDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @objc func authTapped() {
        viewModel.auth()
    }

    @objc private func registerTapped() {
        viewModel.register()
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let curr = textField.text ?? .init()
        let next = (curr as NSString).replacingCharacters(in: range, with: string)
        if textField == emailTextField {
            viewModel.email = next
        } else if textField == passwordTextField {
            viewModel.password = next
        }
        return true
    }
}
