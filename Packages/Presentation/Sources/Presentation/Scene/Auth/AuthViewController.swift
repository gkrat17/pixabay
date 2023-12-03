//
//  AuthViewController.swift
//
//  Created by Giorgi Kratsashvili on 12/3/23.
//

import UIKit
import Combine

final class AuthViewController: UIViewController, UITextFieldDelegate {
    private var viewModel = AuthViewModel()
    private var cancellables: Set<AnyCancellable> = []

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    private let emailErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()

    private let passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.configure()

        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func setupUI() {
        view.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            emailErrorLabel,
            passwordTextField,
            passwordErrorLabel,
            loginButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupBindings() {
        viewModel.$emailError
            .sink { [weak self] error in
                self?.emailErrorLabel.text = error
            }
            .store(in: &cancellables)

        viewModel.$passwordError
            .sink { [weak self] error in
                self?.passwordErrorLabel.text = error
            }
            .store(in: &cancellables)

        viewModel.$isEnabled
            .sink { [weak self] isEnabled in
                self?.loginButton.isEnabled = isEnabled
            }
            .store(in: &cancellables)
    }

    @objc private func loginButtonTapped() {
        viewModel.auth()
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            viewModel.email = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        } else if textField == passwordTextField {
            viewModel.password = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        }

        return true
    }
}
