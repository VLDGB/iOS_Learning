//
//  LogInViewController.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 22.03.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let loginService = UNLoginService()
    private let loadingOverlay = LoadingOverlay().shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            login()
        }
    }
    
    private func transitionToHome() {
        
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    private func setUpElements() {
        errorLabel.alpha = 0
    }
    
    private func showError(_ error: String) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    private func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Plase fill in all field"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(password: cleanedPassword) == false {
            return "Please make sure your password meets the requirements"
        }
        
        return nil
    }
    
    private func login() {
        loadingOverlay.showOverlay(view: loginView)

        loginService.login(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        ) { authenticationResponse in
            
            self.loadingOverlay.hideOverlayView()
            
            switch authenticationResponse {
            case .success:
                self.transitionToHome()
            case .failure(let error):
                switch error {
                case .wrongCreedentiales:
                    self.showError("Wrong Credentiales")
                default:
                    self.showError("Something went wrong")
                }
            }
        }
    }
}
