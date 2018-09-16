//
//  Constants.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

private let config: [String: Any]? = {
    guard
        let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
        let dicInfo = NSDictionary(contentsOfFile: path),
        let dicConfig = dicInfo[KeysJson.config.rawValue] as? [String: Any]
        else { return nil }
    
    return dicConfig
}()

let urlbase: String = {
    guard
        let urlBase = config?[KeysJson.urlBase.rawValue] as? String
        else { return "" }
    
    return urlBase
}()

let apiKey: String = {
    guard
        let apiKey = config?[KeysJson.apiKey.rawValue] as? String
        else { return "" }
    
    return apiKey
}()

enum KeysJson: String {
    case
    statusMessage = "status_message",
    apiKey = "api_key",
    urlBase = "urlBase",
    config = "config",
    images = "images"
}
