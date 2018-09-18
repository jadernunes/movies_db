//
//  MoviesRswiftTests.swift
//  MoviesDBTests
//
//  Created by Jader Nunes on 2018-09-18.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import XCTest

@testable import MoviesDB

class MoviesRswiftTests: XCTestCase {
    
    func testRswiftViewControllers(){
        var view: UIViewController? = R.storyboard.general.homeTabBarController()
        XCTAssertNotNil(view)
        
        view = R.storyboard.movie.movieDetailViewController()
        XCTAssertNotNil(view)
        
        view = R.storyboard.popular.listPopularViewController()
        XCTAssertNotNil(view)
        
        view = R.storyboard.splashScreen.splashScreenViewController()
        XCTAssertNotNil(view)
        
        view = R.storyboard.topRated.listTopRatedViewController()
        XCTAssertNotNil(view)
    }
    
    func testRswiftXibs(){
        var view: UINib? = R.nib.loadingCollectionViewCell()
        XCTAssertNotNil(view)
        
        view = R.nib.movieCollectionViewCell()
        XCTAssertNotNil(view)
    }
    
    func testRswiftStrings(){
        var text = R.string.localizable.messageLoadDataFail()
        XCTAssertGreaterThan(text.count, 0)
        
        text = R.string.localizable.messageLoadGenreListFail()
        XCTAssertGreaterThan(text.count, 0)
        
        text = R.string.localizable.messageLoadImagesFail()
        XCTAssertGreaterThan(text.count, 0)
        
        text = R.string.localizable.messageLoadMovieDetailFail()
        XCTAssertGreaterThan(text.count, 0)
        
        text = R.string.localizable.messageLoadPopularFail()
        XCTAssertGreaterThan(text.count, 0)
        
        text = R.string.localizable.messageLoadTopRatedFail()
        XCTAssertGreaterThan(text.count, 0)
        
        text = R.string.localizable.messageRequestFail()
        XCTAssertGreaterThan(text.count, 0)
    }
    
    func testRswiftImages(){
        var image = R.image.backdropPlaceholder()
        XCTAssertNotNil(image)
        
        image = R.image.iconClose()
        XCTAssertNotNil(image)
        
        image = R.image.iconPopular()
        XCTAssertNotNil(image)
        
        image = R.image.iconTopRated()
        XCTAssertNotNil(image)
        
        image = R.image.imageSplashScreen()
        XCTAssertNotNil(image)
        
        image = R.image.posterPlaceholder()
        XCTAssertNotNil(image)
    }
    
}
