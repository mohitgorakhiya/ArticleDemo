//
//  ArticlesPresentable.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation

protocol ArticlesPresentable : class {
    var articleTitle : String { get }
    var publishDate : String { get }
    var articleType: ArticleType { get }
}
