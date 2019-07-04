//
//  MainViewModel.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/2/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation

class MainViewModel {
    
    var headerTextList = [String]()
    var searchTypeList = [CellViewModel]()
    var popularTypeList = [CellViewModel]()
    
    func loadTableData()
    {
        headerTextList.append(Constant.SearchHeaderText)
        headerTextList.append(Constant.PopularHeaderText)
        
        searchTypeList.append(CellViewModel.init(articleType: ArticleType.Search, filterText: Constant.SearchArticlesText))
        popularTypeList.append(CellViewModel.init(articleType: ArticleType.MostViewed, filterText: Constant.MostViewedText))
        popularTypeList.append(CellViewModel.init(articleType: ArticleType.MostShared, filterText: Constant.MostSharedText))
        popularTypeList.append(CellViewModel.init(articleType: ArticleType.MostEmailed, filterText: Constant.MostEmailedText))
    }
}
