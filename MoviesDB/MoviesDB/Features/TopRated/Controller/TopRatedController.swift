//
//  TopRatedController.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

final class TopRatedController: TopRatedControllerDelegate {
    
    /*
     We are using a controller to call one or more requests if necessary and mount all data to return it together to ViewModel
     */
    
    //MARK: - Variables
    
    /// Api protocol reference
    private let delegate: TopRatedServiceDelegate
    
    //MARK: - Life cycle
    
    required init(delegate: TopRatedServiceDelegate = TopRatedService()) {
        self.delegate = delegate
    }
    
    //MARK: - Custom methods
    
    func requestTopRated(page: Int, completion: @escaping TopRatedCompletion){
        delegate.requestTopRated(page: page, completion: completion)
    }
}
