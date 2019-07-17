//
//  DataManager.swift
//  NYTimesCore
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation

public class DataManager: NSObject {
    
    typealias DataManagerCompletion = (_ status:Int, _ object: Any? , _ error: Error?) -> (Void)
    
    public static let sharedInstance = DataManager()
    
    internal override init() {
        
        #if (arch(i386) || arch(x86_64))
        logToConsole = true
        #else
        logToConsole = false
        #endif
        
        urlSessionConfiguration =  URLSessionConfiguration.default // Create custom config
        urlSession = URLSession(configuration:urlSessionConfiguration)
    }
    
    internal var urlSessionConfiguration : URLSessionConfiguration
    internal var urlSession : URLSession
    internal var imageCache:Dictionary<String, Any> = [:] // TODO: class to write to file.
    
    public var logToConsole: Bool = true
    
    internal func sendRequest(urlRequest: URLRequest, callback: @escaping DataManagerCompletion) -> Void {
        
        let start = CACurrentMediaTime()
        
        let task = urlSession.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            
            let end = CACurrentMediaTime()
            
            let httpResponse = response as? HTTPURLResponse
            var statusCode = 0
            if ((httpResponse?.statusCode) != nil){
                statusCode = (httpResponse?.statusCode)!
            }
            
            var responseJson:Any?
            if data != nil {
                do {
                    responseJson = try JSONSerialization.jsonObject(with: (data)!, options: [])
                }
                catch{
                    print(error)
                }
            }
            
            if (self.logToConsole) {
                
                print("========================================================================")
                print("URL :", urlRequest.url?.absoluteString ?? "null")
                print("METHOD :", urlRequest.httpMethod ?? "GET")
                
                if(urlRequest.httpMethod == "POST" && (urlRequest.httpBody != nil)){
                    
                    let bodyJson = try? JSONSerialization.jsonObject(with: urlRequest.httpBody!, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any>
                    
                    print("BODY :", bodyJson ?? "null")
                }
                
                print("Time Taken : \((end - start)as NSNumber) secs")
                if let httpResponse = response {
                    print("StatusCode :", (httpResponse as! HTTPURLResponse).statusCode)
                }
                
                print("Response JSON : \(String(describing: responseJson == nil ? "null" : responseJson))")
                print("Error : \(String(describing: error == nil ? "null": error?.localizedDescription))")
                print("========================================================================")
            }
            
            callback(statusCode, responseJson, error)
        })
        
        task.resume()
    }
}

