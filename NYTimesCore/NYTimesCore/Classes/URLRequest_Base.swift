//
//  URLRequest_Base.swift
//  NYTimesCore
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static internal func viewedArticle(period: String, params: [String: String]?) -> URLRequest{
        return getRequest(url: APIRequest.requestURL(path: .viewedArticle(period: period), queryParam: params),
                          headers: nil)
    }
    
    //MARK: -  Private
    
    private enum HTTPMethod: String {
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case delete  = "DELETE"
    }
    
    private func defaultHeader() -> NSDictionary {
        return ["Accept" : "application/json", "Content-Type" : "application/json"] as NSDictionary
    }
    
    //MARK: -  LifeCycle
    private init(url: URL, method: HTTPMethod, headers: [String: String]?, body: NSDictionary?) {
        
        self.init(url: url)
        
        timeoutInterval = 10;
        cachePolicy = .reloadRevalidatingCacheData
        httpShouldUsePipelining = true;
        httpMethod = method.rawValue
        
        let allHeader: NSMutableDictionary = defaultHeader().mutableCopy() as! NSMutableDictionary
        if let _ = headers {
            allHeader.addEntries(from: headers!)
        }
        
        for (headerField, headerValue) in allHeader{
            setValue(headerValue as? String, forHTTPHeaderField: (headerField as? String)!)
        }
        
        if let body:NSDictionary = body {
            if JSONSerialization.isValidJSONObject(body) {
                httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            }
            else {
                print("Invalid Request Format", url.absoluteString, body)
            }
        }
    }
    
    //MARK: -  Helper
    static private func getRequest (url: URL, headers: [String: String]?) -> URLRequest{
        return URLRequest.init(url: url, method: .get, headers: headers, body: nil)
    }
    
}
