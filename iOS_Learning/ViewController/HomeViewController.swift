//
//  HomeViewController.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 22.03.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    func setUpElements() {
        welcomeLabel.text = LocalizedStrings.welcome
    }
}
