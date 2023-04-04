//
//  LogInViewController.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 22.03.2023.
//

import UIKit
import Resolver

class LogInViewController: UIViewController {
    
    @Injected private var loginManager: LoginManagerProtocol
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    
    private let loadingOverlay = LoadingOverlay.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let error = validateFields() else { return login() }
        showError(error)
    }
    
    private func transitionToHome() {
        
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    private func setUpElements() {
        errorLabel.alpha = 0
        emailTextField.placeholder = LocalizedStrings.email
        passwordTextField.placeholder = LocalizedStrings.password
        loginButton.titleLabel?.text = LocalizedStrings.login
    }
    
    private func validateFields() -> String? {
        
        let isAnyTextFieldEmpty = [emailTextField, passwordTextField].contains { textField in
            Utils.isTextFieldEmpty(textField)
        }
        
        if  isAnyTextFieldEmpty {
            return LocalizedStrings.pleaseFillInAllFields
        }
        
        guard let cleanedPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            showErrorAlert(
                title: LocalizedStrings.pleaseMakeSureYourPasswordMeetsTheRequirements,
                message: ""
            ) { action in
                // do nothing
            }
            
            return nil
        }
        
        guard Utils.isPasswordValid(password: cleanedPassword) else {
            return LocalizedStrings.pleaseMakeSureYourPasswordMeetsTheRequirements
        }
        
        return nil
    }
    
    private func showError(_ error: String) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    private func showErrorAlert(title: String, message: String, onDismiss: @escaping (UIAlertAction) -> Void) {
        let dismissAlertAction = UIAlertAction(title: LocalizedStrings.dismiss, style: .cancel, handler: onDismiss)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(dismissAlertAction)
        
        self.present(alert, animated: true)
    }
    
    private func login() {
        loadingOverlay.showOverlay(view: view)
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showErrorAlert(title: LocalizedStrings.somethingWentWrong, message: "") { action in
                // do nothing
            }
            return
        }
        
        loginManager.login(
            email: email,
            password: password
        ) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.loadingOverlay.hideOverlayView()
                
                switch result {
                case .success:
                    self?.transitionToHome()
                case .failure(let error):
                    switch error {
                    case .accessDenied:
                        self?.showErrorAlert(title: LocalizedStrings.wrongCredentials, message: "") { action in
                            // do nothing
                        }
                        
                    default:
                        self?.showErrorAlert(title: LocalizedStrings.somethingWentWrong, message: "") { action in
                            // do nothing
                        }
                    }
                }
            }
        }
    }
}
