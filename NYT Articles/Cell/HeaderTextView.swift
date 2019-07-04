//
//  HeaderTextView.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/2/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class HeaderTextView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            if newValue.width == 0 { return }
            super.frame = newValue
        }
    }
}
