//
//  ArticleListCell.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(articlePresentable: ArticlesPresentable)
    {
        self.titleLabel.text = "Title: \(articlePresentable.articleTitle)"
        
        let dateFormat = articlePresentable.articleType == ArticleType.Search ? Constant.SearchDateFormat : Constant.PopularDateFormat
        self.publishDateLabel.text = "Publish Date: \(articlePresentable.publishDate.convertServerDateToSystemWith(format: dateFormat))"
    }
    
}
