//
//  UIViewControllerExtensions.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 05/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Reachability
    
    func networkConnectionCheck() {
        if !ReachabilityHelper.isInternetAvailable() {
            let alert = UIAlertController(title: "Network Error", message: "You are not connected to the internet.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
}
