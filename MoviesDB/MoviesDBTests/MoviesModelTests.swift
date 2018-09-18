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
    
    func testNextID(){
        let expc = self.expectation(description: #function)
        
        let schema = RLMSchema(objectClasses: [])
        let model = BaseModel(value: basePrimaryKeyModel, schema: schema)
        let service = PopularService()
        
        service.requestPopular(page: 1) { (movies, page, error) in
            model.getNextId(BaseModel.self, key: basePrimaryKeyModel) { (value) in
                expc.fulfill()
                XCTAssertGreaterThan(value, 0)
            }
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testMovieValues(){
        
        let schema = RLMSchema(objectClasses: [])
        let movie = Movie(value: jsonMovie, schema: schema)
        
        XCTAssertEqual(movie.getId().value, 1)
        XCTAssertEqual(movie.getVoteAvarage().value, 1.1)
        XCTAssertEqual(movie.getTitle().value, "a")
        XCTAssertEqual(movie.getPosterPath().value, "b")
        XCTAssertEqual(movie.getOriginalLanguage().value, "c")
        XCTAssertEqual(movie.getBackdropPath().value, "d")
        XCTAssertEqual(movie.isAdult().value, false)
        XCTAssertEqual(movie.getOverview().value, "e")
        XCTAssertEqual(movie.getReleaseDate().value, "f")
        XCTAssertEqual(movie.getGenreIds().value.count, 4)
    }
    
    func testMovieTopRatedValues(){
        
        let schema = RLMSchema(objectClasses: [])
        let movie = MovieTopRated(value: jsonMovie, schema: schema)
        
        XCTAssertEqual(movie.getId().value, 1)
        XCTAssertEqual(movie.getVoteAvarage().value, 1.1)
        XCTAssertEqual(movie.getTitle().value, "a")
        XCTAssertEqual(movie.getPosterPath().value, "b")
        XCTAssertEqual(movie.getOriginalLanguage().value, "c")
        XCTAssertEqual(movie.getBackdropPath().value, "d")
        XCTAssertEqual(movie.isAdult().value, false)
        XCTAssertEqual(movie.getOverview().value, "e")
        XCTAssertEqual(movie.getReleaseDate().value, "f")
        XCTAssertEqual(movie.getGenreIds().value.count, 4)
    }

    func testMoviePopularValues(){
        
        let schema = RLMSchema(objectClasses: [])
        let movie = MovieTopRated(value: jsonMovie, schema: schema)
        
        XCTAssertEqual(movie.getId().value, 1)
        XCTAssertEqual(movie.getVoteAvarage().value, 1.1)
        XCTAssertEqual(movie.getTitle().value, "a")
        XCTAssertEqual(movie.getPosterPath().value, "b")
        XCTAssertEqual(movie.getOriginalLanguage().value, "c")
        XCTAssertEqual(movie.getBackdropPath().value, "d")
        XCTAssertEqual(movie.isAdult().value, false)
        XCTAssertEqual(movie.getOverview().value, "e")
        XCTAssertEqual(movie.getReleaseDate().value, "f")
        XCTAssertEqual(movie.getGenreIds().value.count, 4)
        movie.getGenreNames { (genres) in
            XCTAssertEqual(genres.count, 0)
        }
    }
    
    func testConfigurationValues(){
        
        let schema = RLMSchema(objectClasses: [])
        let config = Configuration(value: jsonConfig, schema: schema)
        
        XCTAssertEqual(config.getId().value, 1)
        XCTAssertEqual(config.getBaseUrl().value, "a")
        XCTAssertEqual(config.getBackdropSizes().value.count, 1)
        XCTAssertEqual(config.getPosterSizes().value.count, 1)
    }
    
    func testGenreListValues(){
        
        let schema = RLMSchema(objectClasses: [])
        let genreList = GenreList(value: jsonGenreList, schema: schema)
        
        XCTAssertEqual(genreList.getId().value, 1)
        XCTAssertEqual(genreList.getName().value, "a")
    }
    
    func testGetAllLocalMovieTopRated(){
        let expc = self.expectation(description: #function)
        
        let serviceConfig = ConfigurationService()
        serviceConfig.requestConfiguration { (config, error) in
            
            XCTAssertNotNil(config)
            XCTAssertNil(error)
            
            let serviceTopRated = TopRatedService()
            serviceTopRated.requestTopRated(page: 1) { (movies, page, error) in
                getObjects(MovieTopRated.self) { (moviesDB) in
                    expc.fulfill()
                    XCTAssertGreaterThan(moviesDB.count, 0)
                }
            }
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testGetAllLocalPopularRated(){
        let expc = self.expectation(description: #function)
        
        let service = PopularService()
        service.requestPopular(page: 1) { (movies, page, error) in
            getObjects(MoviePopular.self) { (moviesDB) in
                expc.fulfill()
                XCTAssertGreaterThan(moviesDB.count, 0)
            }
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
                getObjects(MovieTopRated.self, filter: "id > 1", completion: { (moviesDB) in
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
            
            GenreList.allObjects(completion: { (objects: [GenreList]) in
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
                Movie.allObjects(filter: "id = -1", completion: { (moviesDB) in
                    expc.fulfill()
                    XCTAssertEqual(moviesDB.count, 0)
                })
            }
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
}
