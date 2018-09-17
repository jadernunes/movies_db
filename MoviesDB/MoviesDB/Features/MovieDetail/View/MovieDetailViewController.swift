//
//  MovieDetailViewController.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController {
    
    //MARK: - Variables
    
    /// ViewModel to represent the data
    private var viewModel: MovieDetailViewModel = MovieDetailViewModel()
    
    /// Id of the movie
    var idMovie: Int?
    
    /// DisposeBag use to control memory
    private var disposeBag = DisposeBag()
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageViewBackdrop: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelVoteAverage: UILabel!
    @IBOutlet weak var textViewOverview: UITextView!
    @IBOutlet weak var imageViewPoster: UIImageView!{
        didSet{
            imageViewPoster.layer.cornerRadius = 15
            imageViewPoster.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var buttonClose: UIButton!{
        didSet{
            buttonClose.layer.masksToBounds = false
            buttonClose.layer.shadowColor = UIColor.black.cgColor
            buttonClose.layer.shadowOpacity = 0.5
            buttonClose.layer.shadowOffset = CGSize(width: 1, height: 1)
            buttonClose.layer.shadowRadius = 1
        }
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
    }
    
    //MARK: - Actions
    
    @IBAction func buttonClosePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Custom methods
    
    /// Register and configure view model
    private func setupViewModel(){
        
        //Register Image backdrop
        self.viewModel.backdropPath.asObservable().subscribe({ [weak self] pathImage  in
            guard let pathImage = pathImage.element  else { return }
            self?.imageViewBackdrop.addBackdropImage(subPath: pathImage)
        }).disposed(by: self.disposeBag)
        
        //Register Image poster
        self.viewModel.posterPath.asObservable().subscribe({ [weak self] pathImage  in
            guard let pathImage = pathImage.element  else { return }
            self?.imageViewPoster.addPosterImage(subPath: pathImage)
        }).disposed(by: self.disposeBag)
        
        self.viewModel.name
            .asObservable()
            .bind(to: self.labelName.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.genre
            .asObservable()
            .bind(to: self.labelGenre.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.releaseDate
            .asObservable()
            .bind(to: self.labelReleaseDate.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.voteAverage
            .asObservable()
            .bind(to: self.labelVoteAverage.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.overview.asObservable()
            .bind(to: self.textViewOverview.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.error
            .asObservable()
            .subscribe({ [weak self] object in
                guard
                    let errorElement = object.element,
                    let error = errorElement
                    else { return }
                self?.showErrorMesssage(mesage: error.message)
            })
            .disposed(by: disposeBag)
        
        self.viewModel.isLoading
            .asObservable()
            .subscribe({ object in
                guard let isLoading = object.element, isLoading == true else {
                    DispatchQueue.main.async {
                        self.view.stopLoader()
                    }
                    return
                }
                
                self.view.startLoader()
            })
            .disposed(by: disposeBag)
        
        requestMovieDetail()
    }
    
    /// Request data
    private func requestMovieDetail(){
        guard let idMovie = idMovie else { return }
        self.viewModel.requestData(idMovie: idMovie)
    }
    
}

