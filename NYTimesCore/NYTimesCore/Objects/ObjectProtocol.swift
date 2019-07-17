//
//  ObjectProtocol.swift
//  NYTimesCore
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation

internal protocol ObjectProtocol {
    
    static func inputJSON(json: Dictionary<String, Any>) -> Any;
}
