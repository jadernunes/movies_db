//
//  PopularController.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

final class PopularController: PopularControllerDelegate {
    
    /*
     We are using a controller to call one or more requests if necessary and mount all data to return it together to ViewModel
     */
    
    //MARK: - Variables
    
    /// Api protocol reference
    private let delegate: PopularServiceDelegate
    
    //MARK: - Life cycle
    
    required init(delegate: PopularServiceDelegate = PopularService()) {
        self.delegate = delegate
    }
    
    //MARK: - Custom methods
    
    func requestPopular(page: Int, completion: @escaping PopularCompletion){
        delegate.requestPopular(page: page, completion: completion)
    }
}
