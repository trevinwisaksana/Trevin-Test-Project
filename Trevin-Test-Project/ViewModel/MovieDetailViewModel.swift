//
//  MovieDetailViewModel.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 05/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import SwiftyJSON

protocol MovieDetailViewModel {
    var title: String { get }
    var year: String { get }
    var posterURL: String { get }
    var plot: String { get }
}

protocol MovieDetailDataSourceDelegate: class {
    func didLoadMovieDetailData()
}

struct MovieDetail: MovieDetailViewModel {
    var title: String
    var year: String
    var plot: String
    var posterURL: String
    
    init?(json: JSON) {
        guard let title = json["Title"].string else {
            return nil
        }
        
        guard let plot = json["Plot"].string else {
            return nil
        }
        
        guard let year = json["Year"].string else {
            return nil
        }
        
        guard let posterURL = json["Poster"].string, posterURL != "N/A" else {
            return nil
        }
        
        self.title = title
        self.year = year
        self.posterURL = posterURL
        self.plot = plot
    }
}

class MovieDetailDataSource {
    var movieID: String?
    
    private let networkService = NetworkService()
    
    func fetchMovie(completion: @escaping (MovieDetail?) -> Void) {
        guard let movieID = movieID else { return }
        networkService.fetchMovie(withID: movieID) { (movie, error) in
            if let _ = error {
                completion(nil)
                return
            }
            
            completion(movie)
        }
    }
}
