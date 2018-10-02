//
//  ListPopularViewController.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListPopularViewController: UIViewController {
    
    //MARK: - Variables
    
    /// ViewModel to represent the data
    private var viewModel: ListPopularViewModel = ListPopularViewModel()
    
    /// DisposeBag use to control memory
    private var disposeBag = DisposeBag()
    
    /// Refresh control to show loading
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(requestFirstPage), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionViewPopular: UICollectionView!{
        didSet {
            collectionViewPopular.backgroundColor = UIColor.base()
            collectionViewPopular.delegate = self
            collectionViewPopular.dataSource = self
            collectionViewPopular.register(R.nib.movieCollectionViewCell(), forCellWithReuseIdentifier: R.nib.movieCollectionViewCell.identifier)
            collectionViewPopular.register(R.nib.loadingCollectionViewCell(), forCellWithReuseIdentifier: R.nib.loadingCollectionViewCell.identifier)
        }
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.requestFirstPage()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let _ = self.collectionViewPopular else { return }
        self.reloadListMovies()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    //MARK: - Custom methods
    
    
    /// Configure all UI
    private func configureUI(){
        self.view.backgroundColor = UIColor.base()
        
        //Add refresh controll
        collectionViewPopular.addSubview(refreshControl)
        DispatchQueue.main.async {
            self.refreshControl.beginRefreshing()
            self.collectionViewPopular.setContentOffset(CGPoint(x: 0.0, y: self.view.safeAreaLayoutGuide.heightAnchor.accessibilityFrame.height - self.refreshControl.frame.size.height), animated: true)
        }
    }
    
    ///Reload list of movies
    private func reloadListMovies(){
        self.collectionViewPopular.performBatchUpdates({
            let indexSet = IndexSet(integersIn: 0...0)
            self.collectionViewPopular.reloadSections(indexSet)
        })
    }
    
    /// Register and configure view model
    private func setupViewModel(){
        
        viewModel.movies.asObservable().subscribe({ [weak self] movies  in
            guard let _ = movies.element  else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self?.refreshControl.endRefreshing()
                self?.reloadListMovies()
            })
        }).disposed(by: self.disposeBag)
        
        viewModel.isLoading.asObservable().subscribe({ [weak self] isLoading  in
            DispatchQueue.main.async {
                guard let isLoading = isLoading.element  else { return }
                if isLoading == false {
                    self?.refreshControl.endRefreshing()
                }
            }
        }).disposed(by: self.disposeBag)
        
        self.viewModel.error
            .asObservable()
            .subscribe({ [weak self] object in
                guard
                    let errorElement = object.element,
                    let error = errorElement
                    else { return }
                DispatchQueue.main.async {
                    self?.showErrorMesssage(mesage: error.message)
                }
            })
            .disposed(by: disposeBag)
        
        self.viewModel.isLoadingFirstRequest
            .asObservable()
            .subscribe({ [weak self] object in
                guard let isLoading = object.element, isLoading == true else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                        self?.view.stopLoader()
                    })
                    return
                }
                
                DispatchQueue.main.async {
                    self?.view.startLoader()
                }
            })
            .disposed(by: disposeBag)
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

extension ListPopularViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openMovieDetail(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.requestMoreMovies(index: indexPath.row)
    }
}

//MARK: - CollectionView Datasource

extension ListPopularViewController: UICollectionViewDataSource {
    
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

extension ListPopularViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newSize = CGSize(width:(collectionView.frame.width/3)-15, height: (collectionView.frame.width/3) * 1.6)
        return newSize
    }
}
