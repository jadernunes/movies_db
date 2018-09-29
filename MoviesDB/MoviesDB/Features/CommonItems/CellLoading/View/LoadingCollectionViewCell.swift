//
//  LoadingCell.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoadingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var activityIndicatorLoading: UIActivityIndicatorView!
    
    /// Configure all view data
    func configure(){
        activityIndicatorLoading.startAnimating()
    }
}
