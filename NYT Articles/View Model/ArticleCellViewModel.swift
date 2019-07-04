//
//  ArticleCellViewModel.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation

class ArticleCellViewModel {
    
    var articleObj: ArticlesList!
    init(articleObj: ArticlesList) {
        self.articleObj = articleObj
    }
}

extension ArticleCellViewModel: ArticlesPresentable
{
    var articleType: ArticleType {
        return articleObj.articleType
    }
    
    var articleTitle: String {
        return articleObj.articleTitle ?? ""
    }
    
    var publishDate: String {
        return articleObj.publishDate ?? ""
    }    
}
