//
//  ListTopRatedViewController.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListTopRatedViewController: UIViewController {
    
    //MARK: - Variables
    
    /// ViewModel to represent the data
    private var viewModel: ListTopRatedViewModel = ListTopRatedViewModel()
    
    /// DisposeBag use to control memory
    private var disposeBag = DisposeBag()
    
    let refreshControl = UIRefreshControl()
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionViewTopRated: UICollectionView!{
        didSet {
            collectionViewTopRated.delegate = self
            collectionViewTopRated.dataSource = self
            collectionViewTopRated.register(R.nib.movieCollectionViewCell(), forCellWithReuseIdentifier: R.nib.movieCollectionViewCell.identifier)
            collectionViewTopRated.register(R.nib.loadingCollectionViewCell(), forCellWithReuseIdentifier: R.nib.loadingCollectionViewCell.identifier)
        }
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.addTarget(self, action: #selector(self.requestFirstPage), for: .valueChanged)
        self.collectionViewTopRated.addSubview(self.refreshControl)
        
        setupViewModel()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let collectionView = self.collectionViewTopRated else { return }
        collectionView.reloadData()
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    //MARK: - Custom methods
    
    /// Register and configure view model
    private func setupViewModel(){
        
        viewModel.movies.asObservable().subscribe({ [weak self] movies  in
            guard let _ = movies.element  else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self?.refreshControl.endRefreshing()
                self?.collectionViewTopRated.reloadData()
            })
        }).disposed(by: self.disposeBag)
        
        viewModel.isLoading.asObservable().subscribe({ [weak self] isLoading  in
            guard let isLoading = isLoading.element  else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                if isLoading == false {
                    self?.refreshControl.endRefreshing()
                }
            })
        }).disposed(by: self.disposeBag)
        
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
        
        self.viewModel.isLoadingFirstRequest
            .asObservable()
            .subscribe({ [weak self] object in
                guard let isLoading = object.element, isLoading == true else {
                    DispatchQueue.main.async {
                        self?.view.stopLoader()
                    }
                    return
                }
                
                self?.view.startLoader()
            })
            .disposed(by: disposeBag)
        
        requestFirstPage()
    }
    
    /// Request firs page
    @objc private func requestFirstPage(){
        self.refreshControl.beginRefreshing()
        self.viewModel.requestFirstPage()
    }
    
    private func openMovieDetail(index: Int){
        let movie = viewModel.movies.value[index]
        viewModel.openMovieDetail(idMovie: movie.getId().value)
    }
    
    private func showCellLoaging(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.loadingCollectionViewCell.identifier, for: indexPath) as? LoadingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure()
        return cell
    }
    
    private func showCellMovie(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.movieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.movies.value[indexPath.row]
        cell.viewModel.movie = movie
        return cell
    }
}

//MARK: - CollectionView Delegate

extension ListTopRatedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openMovieDetail(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.requestMoreMovies(index: indexPath.row)
    }
}

//MARK: - CollectionView Datasource

extension ListTopRatedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == viewModel.movies.value.count {
            return showCellLoaging(collectionView: collectionView, indexPath: indexPath)
        } else {
            return showCellMovie(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
}


//MARK: - CollectionView Flow Layout

extension ListTopRatedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newSize = CGSize(width:(collectionView.frame.width/3)-15, height: (collectionView.frame.width/3) * 1.6)
        return newSize
    }
}
