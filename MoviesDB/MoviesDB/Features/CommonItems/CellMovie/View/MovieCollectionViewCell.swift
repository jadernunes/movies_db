//
//  MovieCollectionViewCell.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageViewPoster: UIImageView!{
        didSet{
            imageViewPoster.layer.cornerRadius = 15
            imageViewPoster.layer.masksToBounds = true
        }
    }
    
    /// DisposeBag use to control memory
    private var disposeBag = DisposeBag()
    
    //MARK: - Variables
    
    var viewModel: MovieCellViewModel = MovieCellViewModel()
    
    //MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupBind()
    }
    
    //MARK: - Custom methods
    
    private func setupBind(){
        
        viewModel.title
            .asObservable()
            .bind(to: labelTitle.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.genre
            .asObservable()
            .bind(to: labelGenre.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.date
            .asObservable()
            .bind(to: labelDate.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.urlPoster
            .asObservable()
            .subscribe({ pathObject in
                let path = pathObject.element ?? ""
                self.imageViewPoster.addPosterImage(subPath: path)
            }).disposed(by: disposeBag)
    }
}
