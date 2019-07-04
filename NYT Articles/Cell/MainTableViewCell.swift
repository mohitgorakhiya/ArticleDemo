//
//  MainCellViewTableViewCell.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/2/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(cellModel: CellViewModel)
    {
        self.titleLabel.text = cellModel.filterText
    }
    
}
