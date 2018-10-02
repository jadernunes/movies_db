//
//  MoviesModelTests.swift
//  MoviesDBTests
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import XCTest
import Realm
import RealmSwift

@testable import MoviesDB

class MoviesModelTests: XCTestCase {
    
    private let jsonMovie = [
        "id":1,
        "vote_average":1.1,
        "title":"a",
        "poster_path":"b",
        "original_language":"c",
        "backdrop_path":"d",
        "adult":false,
        "overview":"e",
        "release_date":"f",
        "genre_ids":[1,2,3,4],
        ] as [String : Any]
    
    private let jsonConfig = [
        "id":1,
        "base_url":"a",
        "backdrop_sizes":["a"],
        "poster_sizes":["a"]
        ] as [String : Any]
    
    private let jsonGenreList = [
        "id":1,
        "name":"a"
        ] as [String : Any]
    
    func testMovieValues(){
        
        let schema = RLMSchema(objectClasses: [ConfigurationDB.self, GenreList.self, Movie.self, MovieTopRated.self, MoviePopular.self])
        let movie = Movie(value: jsonMovie, schema: schema)
        
        XCTAssertEqual(movie.getId(), 1)
        XCTAssertEqual(movie.getVoteAvarage(), 1.1)
        XCTAssertEqual(movie.getTitle(), "a")
        XCTAssertEqual(movie.getPosterPath(), "b")
        XCTAssertEqual(movie.getOriginalLanguage(), "c")
        XCTAssertEqual(movie.getBackdropPath(), "d")
        XCTAssertEqual(movie.isAdult(), false)
        XCTAssertEqual(movie.getOverview(), "e")
        XCTAssertEqual(movie.getReleaseDate(), "f")
    }
    
    func testMovieTopRatedValues(){
        
        let schema = RLMSchema(objectClasses: [ConfigurationDB.self, GenreList.self, Movie.self, MovieTopRated.self, MoviePopular.self])
        let movie = MovieTopRated(value: jsonMovie, schema: schema)
        
        XCTAssertEqual(movie.getId(), 1)
        XCTAssertEqual(movie.getVoteAvarage(), 1.1)
        XCTAssertEqual(movie.getTitle(), "a")
        XCTAssertEqual(movie.getPosterPath(), "b")
        XCTAssertEqual(movie.getOriginalLanguage(), "c")
        XCTAssertEqual(movie.getBackdropPath(), "d")
        XCTAssertEqual(movie.isAdult(), false)
        XCTAssertEqual(movie.getOverview(), "e")
        XCTAssertEqual(movie.getReleaseDate(), "f")
        XCTAssertEqual(movie.getGenreIds().count, 4)
    }

    func testMoviePopularValues(){
        
        let schema = RLMSchema(objectClasses: [ConfigurationDB.self, GenreList.self, Movie.self, MovieTopRated.self, MoviePopular.self])
        let movie = MovieTopRated(value: jsonMovie, schema: schema)
        
        XCTAssertEqual(movie.getId(), 1)
        XCTAssertEqual(movie.getVoteAvarage(), 1.1)
        XCTAssertEqual(movie.getTitle(), "a")
        XCTAssertEqual(movie.getPosterPath(), "b")
        XCTAssertEqual(movie.getOriginalLanguage(), "c")
        XCTAssertEqual(movie.getBackdropPath(), "d")
        XCTAssertEqual(movie.isAdult(), false)
        XCTAssertEqual(movie.getOverview(), "e")
        XCTAssertEqual(movie.getReleaseDate(), "f")
        XCTAssertEqual(movie.getGenreIds().count, 4)
        movie.getGenreNames { (genres) in
            XCTAssertEqual(genres.count, 0)
        }
    }
    
    func testConfigurationValues(){
        
        let schema = RLMSchema(objectClasses: [ConfigurationDB.self, GenreList.self, Movie.self, MovieTopRated.self, MoviePopular.self])
        let config = ConfigurationDB(value: jsonConfig, schema: schema)
        
        XCTAssertEqual(config.getId(), 1)
        XCTAssertEqual(config.getBaseUrl(), "a")
        XCTAssertEqual(config.getBackdropSizes().count, 1)
        XCTAssertEqual(config.getPosterSizes().count, 1)
    }
    
    func testGenreListValues(){
        
        let schema = RLMSchema(objectClasses: [ConfigurationDB.self, GenreList.self, Movie.self, MovieTopRated.self, MoviePopular.self])
        let genreList = GenreList(value: jsonGenreList, schema: schema)
        
        XCTAssertEqual(genreList.getId(), 1)
        XCTAssertEqual(genreList.getName(), "a")
    }
    
    func testGetAllLocalMovieTopRated(){
        let expc = self.expectation(description: #function)

        let serviceConfig = ConfigurationService()
        serviceConfig.requestConfiguration { (config, error) in

            XCTAssertNotNil(config)
            XCTAssertNil(error)

            let serviceTopRated = TopRatedService()
            serviceTopRated.requestTopRated(page: 1) { (movies, page, error) in
                allObjects(type: MovieTopRated.self, completion: { (moviesDB) in
                    expc.fulfill()
                    XCTAssertGreaterThan(moviesDB.count, 0)
                })
            }
        }

        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testGetAllLocalPopularRated(){
        let expc = self.expectation(description: #function)
        
        let service = PopularService()
        service.requestPopular(page: 1) { (movies, page, error) in
            allObjects(type: MoviePopular.self, completion: { (moviesDB) in
                expc.fulfill()
                XCTAssertGreaterThan(moviesDB.count, 0)
            })
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testGetAllObjectWithFilter(){
        let expc = self.expectation(description: #function)
        
        let serviceConfig = ConfigurationService()
        serviceConfig.requestConfiguration { (config, error) in
            
            XCTAssertNotNil(config)
            XCTAssertNil(error)
            
            let serviceTopRated = TopRatedService()
            serviceTopRated.requestTopRated(page: 1) { (movies, page, error) in
                allObjects(type: MoviePopular.self, filter: "id > 1", completion: { (moviesDB) in
                    expc.fulfill()
                    XCTAssertGreaterThan(moviesDB.count, 0)
                })
            }
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testGetAllGenres(){
        let expc = self.expectation(description: #function)
        
        let serviceConfig = ConfigurationService()
        serviceConfig.requestConfiguration { (config, error) in
            
            XCTAssertNotNil(config)
            XCTAssertNil(error)
            
            allObjects(type: GenreList.self, completion: { (objects: [GenreList]) in
                expc.fulfill()
                XCTAssertGreaterThan(objects.count, 0)
            })
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testGetAllMovieWithFilter(){
        let expc = self.expectation(description: #function)
        
        let serviceConfig = ConfigurationService()
        serviceConfig.requestConfiguration { (config, error) in
            
            XCTAssertNotNil(config)
            XCTAssertNil(error)
            
            let serviceTopRated = TopRatedService()
            serviceTopRated.requestTopRated(page: 1) { (movies, page, error) in
                allObjects(type: Movie.self, filter: "id = -1", completion: { (moviesDB) in
                    expc.fulfill()
                    XCTAssertEqual(moviesDB.count, 0)
                })
            }
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
}
