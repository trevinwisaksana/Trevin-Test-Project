//
//  ViewModel.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 04/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import SwiftyJSON

protocol MovieViewModel: MovieCellViewModel {
    var title: String { get }
    var year: String { get }
    var posterURL: String { get }
}

protocol MovieDataSourceDelegate: class {
    func didLoadMovieData()
}

struct Movie: MovieViewModel {
    var title: String
    var year: String
    var posterURL: String
    
    init?(json: JSON) {
        guard let title = json["Title"].string else {
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
    }
}

final class MovieDataSource {
    
    private var movies = [Movie]() {
        didSet {
            delegate?.didLoadMovieData()
        }
    }
    
    private let networkService = NetworkService()
    
    weak var delegate: MovieDataSourceDelegate?
    
    var numberOfMovies: Int {
        return movies.count
    }
    
    func movie(atIndex indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
    func fetchMovies() {
        
    }
    
    func fetchMovies(withTitle title: String) {
        networkService.fetchMovie(withTitle: title) { (movies, error) in
            if let _ = error {
                return
            }
            
            self.movies = movies
        }
    }
}
