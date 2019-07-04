//
//  CellViewModel.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/2/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation

class CellViewModel{
    
    var articleType: ArticleType!
    var filterText: String!
    init(articleType: ArticleType, filterText: String) {
        self.articleType = articleType
        self.filterText = filterText
    }
}
