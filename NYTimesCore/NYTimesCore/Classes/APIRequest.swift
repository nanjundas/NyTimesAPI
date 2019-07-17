//
//  APIRequest.swift
//  NYTimesCore
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation

internal class APIRequest {
    
    private enum ReleaseType: String {
        case DEV = "https://api.nytimes.com/svc/mostpopular/v2/"
    }
    
    static private let releaseType = ReleaseType.DEV
    
    internal class func baseURL() -> URL {
        return URL(string: releaseType.rawValue)!
    }
    
    class internal func defaultParams() -> Dictionary<String, String>{
        return ["api-key" : "TiEqPv4FaLP7EAmBctgtmHfcilZtgZ5H"]
    }
    
    //MARK: -  Url
    internal class func requestURL(path: URLPath, queryParam: [String: String]?) -> URL {
        
        let url = URL.init(string: path.value(), relativeTo: baseURL())
        
        var components = URLComponents.init(string: url!.absoluteString)
        
        var queryItems = [URLQueryItem]()
        
        var allParams = APIRequest.defaultParams()
        
        if let queryParam = queryParam{
            for (key,value) in queryParam {
                allParams.updateValue(value, forKey:key)
            }
        }
        
        for(key, value) in allParams {
            queryItems.append((URLQueryItem.init(name: key, value: value)))
        }
        
        components?.queryItems = queryItems
        
        return (components!.url)!
    }
    
    internal class func requestURL(path: URLPath) -> URL {
        return requestURL(path: path, queryParam: nil)
    }
    
    internal enum URLPath {
        
        case viewedArticle(period: String)
        
        func value() -> String {
            
            switch self {
            case .viewedArticle(let period):
                return "viewed/\(period).json"
            }
        }
    }
}
