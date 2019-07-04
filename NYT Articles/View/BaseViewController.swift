//
//  BaseViewController.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func displayMessageAlertWithTitle(alertTitle: String, withTitle alertMessage: String)
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            
        })
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func CheckForInternetConnection() -> Bool
    {
        do {
            let reachability: Reachability = try Reachability()
            let netStatus = reachability.connection
            
            if netStatus == Reachability.Connection.unavailable
            {
                return false
            }
            
            return true
            
        } catch {
            
            return true
        }
        
    }
}
