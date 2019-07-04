//
//  WebService.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation
typealias CompletionBlock = (Bool, Dictionary<String, Any>?, String?) -> Void

class WebService {
    
    static let shared = WebService()
    
    func fetchArticles(request: URLRequest, completion: @escaping (CompletionBlock)) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {
                    completion(false, nil, "")
                    return
            }
            
            if let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            {
                let status = responseObject["status"] as! String
                if status == Constant.SuccessText
                {
                    completion(true, responseObject, nil)
                }
                else
                {
                    let errors = responseObject["errors"] as! Array<String>
                    let errorMessage = errors.joined(separator: ", ")
                    completion(false, nil, errorMessage)
                }
            }
        }
        task.resume()
        
    }
    
}
