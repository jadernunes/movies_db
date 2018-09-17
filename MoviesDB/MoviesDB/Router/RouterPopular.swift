//
//  RouterPopular.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit

final class RouterPopular {
    
    enum ScreenName {
        case movieDetail
    }
    
    func navigate(screen: ScreenName, idMovie: Int = -1){
        switch screen {
        case .movieDetail:
            openMovieDetail(idMovie: idMovie)
            break
        }
    }
    
    private func openMovieDetail(idMovie: Int){
        guard let viewController = R.storyboard.movie.movieDetailViewController() else { return }
        viewController.idMovie = idMovie
        viewController.modalTransitionStyle = .crossDissolve
        Utils.visibleViewController()?.present(viewController, animated: true)
    }
}
