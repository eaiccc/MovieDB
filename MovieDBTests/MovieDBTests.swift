//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Mac on 2018/7/27.
//  Copyright © 2018年 Link. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieDBTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchDiscoverMovie(){
        let e = expectation(description: "FetchDiscoverMovie")
        MovieApi.getDiscoverMovie( "2017-07-31", sortBy:"release_date.desc", page: 1) { result in
            do {
                let movieDiscover = try result.unwrap()
                e.fulfill()
                if movieDiscover.movies.count > 0 {
                    
                }else{
                    XCTFail("fetch movie Discover nothing");
                }
                
            } catch let error as NSError {
                e.fulfill()
                
                XCTFail("fetch movie Discover : \(error.localizedDescription)");
            }
            
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func testFetchMovieDetail(){
         let e = expectation(description: "FetchMovieDetail")
        //let movieId = 111111 //incorrect id
        let movieId = 111 //correct id
        MovieApi.getMovieDetail( movieId) { result in
            do {
                let movie = try result.unwrap()
                if movie.movieId != movieId {
                    e.fulfill()
                    XCTFail("fetch movie detail error : wrong id");
                    
                }
                 e.fulfill()
            } catch let error as NSError {
                e.fulfill()
                XCTFail("fetch movie detail fail: \(error.localizedDescription)");
                
            }
        
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
   
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
