//
//  ListPopularViewModel.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ListPopularViewModel {
    
    //MARK: - Variables
    
    /// Api protocol reference
    private var delegate: PopularControllerDelegate
    
    /// Contains movies data
    var movies: Variable<[MoviePopularRepresentable]> = Variable<[MoviePopularRepresentable]>([])
    
    /// Control the request loading status. If TRUE will start the loading and FALSE stop that
    var isLoading: Variable<Bool> = Variable<Bool>(true)
    
    /// Control the first request loading status. If TRUE will start the loading and FALSE stop that
    var isLoadingFirstRequest: Variable<Bool> = Variable<Bool>(true)
    
    /// Number of movies
    var numberOfRows = 0
    
    /// Current page
    private var page = 1
    
    /// Next page
    private var nextPage = 0
    
    /// Error when call request
    var error: Variable<ErrorMoviesDB?> = Variable<ErrorMoviesDB?>(nil)
    
    //MARK: - Life cycle
    
    /// Initialize the ViewModel with a delegate if it'll be necessary
    ///
    /// - Parameter delegate: Optional Controller protocol reference. You can override it if will be necessary
    init(delegate: PopularControllerDelegate = PopularController()) {
        self.delegate = delegate
    }
    
    //MARK: - Custom methods
    
    /// Request new updated data to View Model and then it'll update
    func requestPopular(page: Int? = nil, completion:(() -> Void)? = nil){
        self.numberOfRows = 0
        self.isLoading.value = true
        if nextPage == 0 {
            isLoadingFirstRequest.value = true
        }
        
        allObjects(type: MoviePopular.self) { [weak self] (movies: [MoviePopular]) in
            let result = movies.map({ (realmObject) -> MoviePopularRepresentable in
                return MoviePopularRepresentable(moviePopular: realmObject)
            })
            
            if self?.nextPage == 0 {
                self?.movies.value = result
            }
            
            self?.delegate.requestPopular(page: page ?? self?.page ?? 0) { [weak self] (movies, pageReceived, errorCustom) in
                if movies.count > 0 {
                    self?.movies.value.append(contentsOf: movies)
                }
                
                self?.error.value = errorCustom
                self?.isLoadingFirstRequest.value = false
                self?.isLoading.value = false
                self?.nextPage = pageReceived
                let countMovies = self?.movies.value.count ?? 0
                self?.numberOfRows = countMovies == 0 ? 1 : countMovies + 1
                completion?()
            }
        }
    }
    
    /// Request new data based on current page
    ///
    /// - Parameter indexPath: indexPath of the cell
    func requestMoreMovies(index: Int){
        if index == self.movies.value.count && page == nextPage {
            self.page += 1
            self.requestPopular()
        }
    }
    
    /// Request firstPage
    func requestFirstPage(){
        self.isLoading.value = true
        if self.movies.value.count == 0 {
            self.requestPopular(page: 1)
        } else {
            self.isLoading.value = false
        }
    }
    
    /// Open detail movie
    ///
    /// - Parameters:
    ///   - idMovie: id of the Movie
    func openMovieDetail(idMovie: Int){
        RouterPopular().navigate(screen: .movieDetail, idMovie: idMovie)
    }
}
