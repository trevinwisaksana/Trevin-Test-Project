//
//  DummyDataFactory.swift
//  Trevin-Test-ProjectTests
//
//  Created by Trevin Wisaksana on 05/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import SwiftyJSON
@testable import Trevin_Test_Project

class DummyDataFactory {
    
    // MARK: - Ample
    
    func ampleMoviePostersData() -> [JSON] {
        let testBundle = Bundle(for: type(of: self))
        
        guard let path = testBundle.path(forResource: "ample_movie_search_data", ofType: "json") else {
            fatalError("Failed to retrieve data.")
        }
        
        guard let data = NSData(contentsOfFile: path) else {
            fatalError("Failed to retrieve data.")
        }
        
        guard let jsonArray = JSON(data)["Search"].array else {
            fatalError("Failed to parse data.")
        }
        
        return jsonArray
    }
    
    func ampleMovieDetailData() -> JSON {
        let testBundle = Bundle(for: type(of: self))
        
        guard let path = testBundle.path(forResource: "ample_movie_detail_data", ofType: "json") else {
            fatalError("Failed to retrieve data.")
        }
        
        guard let data = NSData(contentsOfFile: path) else {
            fatalError("Failed to retrieve data.")
        }
        
        return JSON(data)
    }
    
    // MARK: - Faulty
    
    func faultyMoviePostersData() -> [JSON] {
        let testBundle = Bundle(for: type(of: self))
        
        guard let path = testBundle.path(forResource: "faulty_movie_search_data", ofType: "json") else {
            fatalError("Failed to retrieve data.")
        }
        
        guard let data = NSData(contentsOfFile: path) else {
            fatalError("Failed to retrieve data.")
        }
        
        guard let jsonArray = JSON(data)["Search"].array else {
            fatalError("Failed to parse data.")
        }
        
        return jsonArray
    }
    
}
