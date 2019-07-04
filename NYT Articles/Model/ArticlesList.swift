//
//  ArticlesList.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation

struct ArticlesList {
    
    var articleTitle: String?
    var publishDate: String?
    var articleType: ArticleType!
    
    init(docObj: Dictionary<String, Any>, articleType: ArticleType) {
        
        if let headelineDict = docObj["headline"] as? Dictionary<String, Any>
        {
            articleTitle = headelineDict["main"] as? String
        }
        
        if let pub_date = docObj["pub_date"] as? String
        {
            publishDate = pub_date
        }
        self.articleType = articleType
    }
    
    init(popularObj: Dictionary<String, Any>, articleType: ArticleType) {
        
        if let title = popularObj["title"] as? String
        {
            articleTitle = title
        }
        
        if let pub_date = popularObj["published_date"] as? String
        {
            publishDate = pub_date
        }
        
        self.articleType = articleType
    }
}
