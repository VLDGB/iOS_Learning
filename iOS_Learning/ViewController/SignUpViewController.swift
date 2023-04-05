//
//  SignUpViewController.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 22.03.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let signUpService: SignUpService = UNSignUpService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            signUp()
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
    
    private func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Plase fill in all field"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(password: cleanedPassword) == false {
            return "Please make sure your password meets the requirements"
        }
        
        return nil
    }
    
    private func showError(_ error: String) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    private func signUp() {
        signUpService.signUp(
            name: firstNameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        ) { response in
            switch response {
            case .success:
                self.transitionToHome()
            case .failure:
                self.showError("Something went wrong")
            }
        }
    }
}
