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
    
    /// Configuration service delegate
    private let delegateConfiguration: ConfigurationServiceDelegate
    
    // Genre list service delegate
    private let delegateGenreList: GenreListServiceDelegate
    
    //MARK: - Life cycle
    
    required init(delegateConfiguration: ConfigurationServiceDelegate = ConfigurationService(), delegateGenreList: GenreListServiceDelegate = GenreListService()) {
        self.delegateConfiguration = delegateConfiguration
        self.delegateGenreList = delegateGenreList
    }
    
    //MARK: - Custom methods
    
    func requestInitialData(completion: @escaping InitialDataCompletion){
        delegateConfiguration.requestConfiguration { (configuration, errorConfig) in
            self.delegateGenreList.requestGenreList(completion: { (genres, errorGenre) in
                let error = errorConfig ?? errorGenre
                let success = error == nil
                completion(success, error)
            })
        }
    }
}
