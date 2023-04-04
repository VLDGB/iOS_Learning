//
//  LoadingOverlay.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 28.03.2023.
//

import UIKit

struct LoadingOverlay {
    
    static let shared = LoadingOverlay()
    
    private var overlayView = UIView(frame: UIScreen.main.bounds)
    private var activityIndicator = UIActivityIndicatorView(style: .large)
        
    private init() {}
    
    func showOverlay(view: UIView!) {
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    
    func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
