//
//  ArticlesListViewModel.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation

protocol ArticlesListViewModeldDelegate {
    func updateUIAfterFetchData()
    func validationFailure(title: String, message: String)
}

class ArticlesListViewModel {
    
    var isMoreDataAvailable: Bool = true
    var isDataLoading: Bool = false
    var articlesList = [ArticlesPresentable]()
    var pageNumber: Int = 0
    var searchText: String!
    var articleType: ArticleType!
    var delegate: ArticlesListViewModeldDelegate?
    
    init(delegate: ArticlesListViewModeldDelegate?) {
        self.delegate = delegate
    }
    
    func numberOfRows(section : Int) -> Int {
        
        if section == 1
        {
            return 1
        }
        
        return self.articlesList.count
    }
    
    func numberOfSection() -> Int
    {
        if self.articleType == ArticleType.Search && self.isMoreDataAvailable && self.articlesList.count > 0
        {
            return 2
        }
        return 1
    }
    
    func fetchArticles() {
        
        var components: URLComponents!
        var queryItems = [URLQueryItem]()
        if articleType == ArticleType.Search
        {
            components = URLComponents.init(string: Constant.Search_API)
            queryItems.append(URLQueryItem(name: "q", value: self.searchText))
            queryItems.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
        }
        else if articleType == ArticleType.MostViewed
        {
            components = URLComponents.init(string: Constant.MostViewed_API)
        }
        else if articleType == ArticleType.MostShared
        {
            components = URLComponents.init(string: Constant.MostShared_API)
        }
        else if articleType == ArticleType.MostEmailed
        {
            components = URLComponents.init(string: Constant.MostEmailed_API)
        }
        
        queryItems.append(URLQueryItem(name: "api-key", value: Constant.API_Key))
        components.queryItems = queryItems
        
        let request = URLRequest(url: components.url!)
        
        WebService.shared.fetchArticles(request: request) { (status, responseObj, message) in
            if status
            {
                if self.articleType == ArticleType.Search
                {
                    let response =  responseObj!["response"] as! Dictionary<String, Any>
                    let offset = (response["meta"] as! Dictionary<String, Any>)["offset"] as? Int ?? 0
                    
                    let totalHits = (response["meta"] as! Dictionary<String, Any>)["hits"] as? Int ?? 0
                    if offset == 0
                    {
                        self.articlesList.removeAll()
                    }
                    
                    if (self.pageNumber + 1) * Constant.ArtclesPerPage >= totalHits
                    {
                        self.isMoreDataAvailable = false
                    }
                    if let docsArray = response["docs"] as? Array<Dictionary<String, Any>>
                    {
                        for doc in docsArray
                        {
                            let articleObj = ArticlesList.init(docObj: doc, articleType: self.articleType)
                            self.articlesList.append(ArticleCellViewModel.init(articleObj: articleObj))
                        }
                    }
                }
                else
                {
                    self.articlesList.removeAll()
                    
                    if let docsArray = responseObj!["results"] as? Array<Dictionary<String, Any>>
                    {
                        for doc in docsArray
                        {
                            let articleObj = ArticlesList.init(popularObj: doc, articleType: self.articleType)
                            self.articlesList.append(ArticleCellViewModel.init(articleObj: articleObj))
                        }
                    }
                }
                
                self.delegate?.updateUIAfterFetchData()
                
            }
            else
            {
                self.isMoreDataAvailable = false
                self.delegate?.validationFailure(title: Constant.AlertTitle, message: message ?? "")
            }
        }
    }
}
