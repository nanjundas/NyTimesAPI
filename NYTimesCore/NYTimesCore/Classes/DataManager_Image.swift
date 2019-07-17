//
//  DataManager_Image.swift
//  NYTimesCore
//
//  Created by Nanjunda Swamy on 18/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation

extension DataManager {
    
    public func getImage(urlString: String, completion: @escaping((_ image: UIImage?) -> Void )) -> Void {
        
        if let cachedImage = imageCache[urlString] {
            completion(cachedImage as? UIImage)
        }
        else {
            
            let task:URLSessionDataTask = self.urlSession.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
                
                guard let data = data, let image = UIImage(data: data) else {
                    
                    DispatchQueue.main.sync {
                        completion(nil)
                    }
                    
                    return
                }
                
                self.imageCache[urlString]  = image
                
                DispatchQueue.main.sync {
                    completion(image)
                }
            })
            
            task.resume()
        }
    }
    
}
