//
//  SplashScreenController.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

final class SplashScreenController: SplashScreenControllerDelegate {
    
    /*
     We are using a controller to call one or more requests if necessary and mount all data to return it together to ViewModel
     */
    
    //MARK: - Variables
    
    /// Api protocol reference
    private let delegate: SplashScreenServiceDelegate
    
    //MARK: - Life cycle
    
    required init(delegate: SplashScreenServiceDelegate = SplashScreenService()) {
        self.delegate = delegate
    }
    
    //MARK: - Custom methods
    
    func requestConfiguration(completion: @escaping ConfigurationCompletion){
        delegate.requestConfiguration(completion: completion)
    }
}
