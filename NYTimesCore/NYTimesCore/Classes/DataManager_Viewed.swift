//
//  DataManager_Viewed.swift
//  NYTimesCore
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation
import RealmSwift

extension DataManager {
    
    public func getViewedArticles(period:String, params: Dictionary<String, String>?, callback: @escaping (DataManagerResult<Results<Article>>) -> Void) -> Void {
        
        let urlRequest = URLRequest.viewedArticle(period: period , params: params) as URLRequest
        self.sendRequest(urlRequest: urlRequest) { (statusCode, object, error) -> (Void) in
            
            var createdArticles:Array<String> = []
            if(error == nil) {
                
                let results: Dictionary<String, Any> = (object as? [String: Any])!
                let jsonResp = results["results"]  as? Array<Dictionary<String, Any>> ?? []
                
                let realm = try! Realm()
                realm.beginWrite()
                for articleJson in jsonResp {
                    let value = Article.inputJSON(json: articleJson)
                    //realm.create(Article.self, value: value, update: .error)
                    realm.create(Article.self, value: value, update: true)
                    createdArticles.append( String(describing: articleJson["id"] as! Int))
                }
                
                try! realm.commitWrite()
            }
            
            DispatchQueue.main.sync {
                
                var result: DataManagerResult<Results<Article>>
                
                if let error = error {
                    result = DataManagerResult.failure(error)
                }
                else{
                    let realm = try! Realm()
                    let ret:Results<Article> = realm.objects(Article.self).filter("id IN %@", createdArticles)
                    result = DataManagerResult.success(ret)
                }
                
                callback(result)
            }
            
            // Delete Old Objects
            if let params = params {
                if params["page"] == "1" {
                    
                    let realm = try! Realm()
                    realm.beginWrite()
                    for object in realm.objects(Article.self) {
                        let index = createdArticles.firstIndex(of: object.id!)
                        if(index == nil) {
                            realm.delete(object)
                        }
                    }
                    
                    try! realm.commitWrite()
                }
            }
            
        }
    }
}


