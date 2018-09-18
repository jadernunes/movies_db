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
        viewModel.errorInitialData.asObservable().subscribe({ object in
            if self.viewModel.isRequestFinished {
                guard
                    let error = object.element as? ErrorMoviesDB else {
                        self.viewModel.openHomeScreen()
                        return
                }
                
                self.showErrorMesssage(mesage: error.message)
            }
        }).disposed(by: disposeBag)
        requestInitialData()
    }
    
    /// Request initial data
    private func requestInitialData(){
        viewModel.requestInitialData()
    }
    
    //MARK: - Used to unit test
    
    /// Verify if exist error or not
    ///
    /// - Returns: Bool
    func hasErrorInitalData() -> Bool {
        return viewModel.errorInitialData.value != nil
    }
}
