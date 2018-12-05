//
//  Trevin_Test_ProjectTests.swift
//  Trevin-Test-ProjectTests
//
//  Created by Trevin Wisaksana on 04/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Trevin_Test_Project

class Trevin_Test_ProjectTests: XCTestCase {
    
    var dummyDataFactory: DummyDataFactory?

    override func setUp() {
        dummyDataFactory = DummyDataFactory()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSucessfulMoviePostersDataParsing() {
        guard let jsonArray = dummyDataFactory?.ampleMoviePostersData() else {
            fatalError("Failed to retrieve JSON array.")
        }
        
        let moviePoster = jsonArray.compactMap { MoviePoster(json: $0) }
        
        XCTAssertEqual(moviePoster.count, 8)
    }
    
    func testFailingMoviePosterDataParsing() {
        guard let jsonArray = dummyDataFactory?.faultyMoviePostersData() else {
            fatalError("Failed to retrieve JSON array.")
        }
        
        let moviePoster = jsonArray.compactMap { MoviePoster(json: $0) }
        
        XCTAssertEqual(moviePoster.count, 0)
    }
    
    func testSucessfulMovieDetailDataParsing() {
        guard let json = dummyDataFactory?.ampleMovieDetailData() else {
            fatalError("Failed to retrieve JSON data.")
        }
        
        let movieDetail = MovieDetail(json: json)
        
        XCTAssertNotNil(movieDetail)
    }
    
    func testFailingMovieDetailDataParsing() {
        guard let json = dummyDataFactory?.faultyMovieDetailData() else {
            fatalError("Failed to retrieve JSON data.")
        }
        
        let movieDetail = MovieDetail(json: json)
        
        XCTAssertNil(movieDetail)
    }

}
