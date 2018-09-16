//
//  SplashScreenViewModel.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SplashScreenViewModel {
    
    /// Api protocol reference
    private var delegate: SplashScreenControllerDelegate
    
    /// Contains the Configuration
    var configuration: Variable<ErrorMoviesDB?> = Variable<ErrorMoviesDB?>(nil)
    
    /// Control call request if fail
    private var countAttempt = 1
    
    ///Check if request has already finished
    var isRequestFinished = false
    
    /// Initialize the ViewModel with a delegate if it'll be necessary
    ///
    /// - Parameter delegate: Optional Controller protocol reference. You can override it if will be necessary
    init(delegate: SplashScreenControllerDelegate = SplashScreenController()) {
        self.delegate = delegate
    }
    
    func requestConfiguration(){
        delegate.requestConfiguration { (config, error) in
            self.isRequestFinished = true
            if let _ = error {
                if self.countAttempt <= 3 {
                    self.countAttempt += 1
                    self.requestConfiguration()
                }
            }
            
            self.configuration.value = error
        }
    }
    
    func openHomeScreen(){
        RouterSplashScreen().navigate(screen: .home)
    }
}
