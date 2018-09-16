//
//  SplashScreenViewController.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-15.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashScreenViewController: UIViewController {

    //MARK: - Variables
    
    /// ViewModel to represent the data
    private var viewModel: SplashScreenViewModel = SplashScreenViewModel()
    
    /// DisposeBag use to control memory
    private var disposeBag = DisposeBag()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
    }
    
    //MARK: - Custom methods
    
    /// Register and configure view model
    private func setupViewModel(){
        viewModel.configuration.asObservable().subscribe({ object in
            guard
                let error = object.element as? ErrorMoviesDB else {
                //TODO: Navigate
                return
            }
            
            self.showErrorMesssage(mesage: error.message)
        }).disposed(by: disposeBag)
        requestConfigurationData()
    }
    
    /// Request initial data
    private func requestConfigurationData(){
        viewModel.requestConfiguration()
    }
}
