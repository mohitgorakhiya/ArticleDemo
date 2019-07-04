//
//  Constants.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/2/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation

struct Constant
{
    static let API_Key = "NHshQ1gShiuyXnIiijUApIe82a2GlW4T"
    static let Base_URL = "https://api.nytimes.com/svc/"
    
    static let Search_API = Constant.Base_URL + "search/v2/articlesearch.json"
    static let MostEmailed_API = Constant.Base_URL + "mostpopular/v2/emailed/7.json"
    static let MostShared_API = Constant.Base_URL + "mostpopular/v2/shared/1/facebook.json"
    static let MostViewed_API = Constant.Base_URL + "mostpopular/v2/viewed/1.json"
    
    static let ArticlesText = "Articles"
    
    static let MainViewTitle = "New York Articles"
    static let SearchHeaderText = "Search"
    static let PopularHeaderText = "Popular"
    static let SearchArticlesText = "Search Articles"
    static let MostViewedText = "Most Viewed"
    static let MostSharedText   = "Most Shared"
    static let MostEmailedText = "Most Emailed"
    
    
    static let AlertTitle = "Alert"
    static let SearchBlankMessage = "Please enter search text."
    
    static let SuccessText = "OK"
    static let ErrorText = "ERROR"
    static let ErrorMessage = "Some error occured, please try after some time."
    static let NoInternetMessage = "Please check your internet connection."
    static let NoDataFound = "No Articles Available!."
    
    static let ArtclesPerPage = 10
    
    static let SearchDateFormat = "yyyy-MM-dd HH:mm:ssZZZZ"
    static let PopularDateFormat = "yyyy-MM-dd"
}
