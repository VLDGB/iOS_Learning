//
//  SignUpViewController.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 22.03.2023.
//

import UIKit
import Resolver

class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    
    @Injected private var signUpManager: SignUpManagerProtocol
    
    private var loginOverlay = LoadingOverlay.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let error = validateFields() else { return signUp() }
        showError(error)
    }
    
    private func transitionToHome() {
        
        let homeViewController =
        storyboard?
            .instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    private func setUpElements() {
        errorLabel.alpha = 0
        nameTextField.placeholder = LocalizedStrings.name
        emailTextField.placeholder = LocalizedStrings.email
        passwordTextField.placeholder = LocalizedStrings.password
        signUpButton.titleLabel?.text = LocalizedStrings.signUp
    }
    
    private func validateFields() -> String? {
        
        let isAnyTextFieldEmpty = [nameTextField, emailTextField, passwordTextField].contains { textField in
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
    
    private func signUp() {
        loginOverlay.showOverlay(view: view)
        
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {
            showErrorAlert(title: LocalizedStrings.somethingWentWrong, message: "") { action in
                // do nothing
            }
            return
        }
        
        signUpManager.signUp(
            name: name,
            email: email,
            password: password
        ) { [weak self] response in
            
            DispatchQueue.main.async {
                self?.loginOverlay.hideOverlayView()
                
                switch response {
                case .success:
                    self?.transitionToHome()
                case .failure:
                    self?.showErrorAlert(title: LocalizedStrings.somethingWentWrong, message: "") { action in
                        // do nothing
                    }
                }
            }
        }
    }
}
