//
//  Article.swift
//  NYTimesCore
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation
import RealmSwift


final public class Article: Object {
    
    @objc public dynamic var id: String? = nil
    @objc public internal(set) dynamic var title: String? = nil
    @objc public internal(set) dynamic var abstract: String? = nil
    @objc public internal(set) dynamic var section: String? = nil
    @objc public internal(set) dynamic var published_date: String? = nil
    @objc public internal(set) dynamic var byline: String? = nil
    @objc public internal(set) dynamic var realeaseDate: String? = nil
    
    public override class func primaryKey() -> String{
        return "id"
    }
}

extension Article : ObjectProtocol {
    
    static func inputJSON(json: Dictionary<String, Any>) -> Any {
        
        var ret:Dictionary<String, Any> = [:]
        
        ret["id"] = String(describing: json["id"] as! Int)
        ret["title"] = json["title"] as? String
        ret["abstract"] = json["abstract"] as? String
        ret["section"] = json["section"] as? String
        ret["byline"] = json["byline"] as? String
        ret["realeaseDate"] = json["realeaseDate"] as? String
        
        return ret
    }
}
