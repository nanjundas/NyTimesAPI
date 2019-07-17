//
//  DataManagerError.swift
//  NYTimesCore
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation

public enum DataManagerError: Error {
    case unknown(error: Error?)
    case noNetwork
}

public extension DataManagerError {
    
    var localizedDescription: String {
        switch self {
        case .unknown(let error):
            return "Error Occured - \(String(describing: error == nil ? "Unknown" : error?.localizedDescription))"
        case .noNetwork:
            return "Unable to Connect to Server. Please make sure you have proper Internet connection."
        }
    }
}
