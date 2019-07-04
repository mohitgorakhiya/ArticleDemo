//
//  Extension.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func convertServerDateToSystemWith(format: String) -> String
    {
        let strDate = self.replacingOccurrences(of: "T", with: " ")
        var dateFormat = DateFormatter.init()
        dateFormat.dateFormat = format
        
        let pubDate = dateFormat.date(from: strDate) ?? Date.init()
        
        dateFormat = DateFormatter.init()
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .medium
        return dateFormat.string(from: pubDate)
    }
}

extension UIView
{
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
}
