//
//  RegistrationViewController.swift
//
//  Created by Giorgi Kratsashvili on 12/4/23.
//

import DI
import UIKit
import Combine

final class RegistrationViewController: UIViewController {
    @Inject(container: .viewModels) private var viewModel: RegistrationViewModel

    private let emailTextField: UITextField = .email
    private let passwordTextField: UITextField = .password
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Age"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    private let emailErrorLabel: UILabel = .error
    private let passwordErrorLabel: UILabel = .error
    private let ageErrorLabel: UILabel = .error
    private lazy var registerButton: UIButton = {
        let button: UIButton = .button(title: "Register")
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return button
    }()

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

fileprivate extension RegistrationViewController {
    func configure() {
        viewModel.configure()
        configureNavigation()
        configureHierarchy()
        configureDelegates()
        bind()
    }

    func configureNavigation() {
        title = "Registration"
    }

    private func configureHierarchy() {
        view.backgroundColor = .systemBackground
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            emailErrorLabel,
            passwordTextField,
            passwordErrorLabel,
            ageTextField,
            ageErrorLabel,
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

        viewModel.$ageError
            .sink { [weak self] in
                self?.ageErrorLabel.text = $0
            }.store(in: &cancellables)

        viewModel.$isEnabled
            .sink { [weak self] in
                self?.registerButton.isEnabled = $0
            }.store(in: &cancellables)
    }

    func configureDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        ageTextField.delegate = self
    }

    @objc private func registerTapped() {
        viewModel.register()
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let curr = textField.text ?? .init()
        let next = (curr as NSString).replacingCharacters(in: range, with: string)
        if textField == emailTextField {
            viewModel.email = next
        } else if textField == passwordTextField {
            viewModel.password = next
        } else if textField == ageTextField {
            viewModel.age = next
        }
        return true
    }
}
