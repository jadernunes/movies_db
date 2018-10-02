//
//  ApiRequest.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import Alamofire

let apiTimeout = TimeInterval(30)

/// Default Alamofire initialization
private var alamoFireManager: SessionManager = { () -> Alamofire.SessionManager in
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = apiTimeout
    let manager = Alamofire.SessionManager(configuration: configuration)
    return manager
}()

final class ApiRequest: ApiRequestDelegate {
    
    //MARK: - Variables
    
    /// Interface request
    private var httpInterface: SessionManager
    
    //MARK: - Custom methods
    
    /// Initialize the Api with initial configurations
    ///
    /// - Parameter httpInterface: Optional http interface delegate of the type: SessionManager
    init(httpInterface: SessionManager = alamoFireManager) {
        self.httpInterface = httpInterface
    }
    
    func get(withUrl url: String, andParameters params: ParametersApiRequest?, andCompletion completion: @escaping RequestCompletion){
        
        let urlString = "\(urlbase)\(url)"
        
        var params = params ?? ["":""]
        params[KeysJson.apiKey.rawValue] = apiKey
        
        self.httpInterface.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseJSON(
                queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default),
                options: JSONSerialization.ReadingOptions.allowFragments)
            { (response: DataResponse) in
                let errorCustom = ErrorMoviesDB(error: response.result.error)
                do {
                    guard
                        let data = response.data,
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                        let _ = json[KeysJson.statusMessage.rawValue] as? String
                        else {
                            return completion(response.data, errorCustom)
                    }
                    completion(response.data, ErrorMoviesDB(message: R.string.localizable.messageRequestFail()))
                } catch {
                    completion(response.data, errorCustom)
                }
        }
    }
}
