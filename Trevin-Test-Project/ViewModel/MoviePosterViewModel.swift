//
//  ViewModel.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 04/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import SwiftyJSON

protocol MoviePosterViewModel {
    var posterURL: String { get }
    var movieID: String { get }
}

protocol MovieDataSourceDelegate: class {
    func didLoadMovieData()
}

struct MoviePoster: MoviePosterViewModel {
    var movieID: String
    var posterURL: String
    
    init?(json: JSON) {
        guard let movieID = json["imdbID"].string else {
            return nil
        }
        
        guard let posterURL = json["Poster"].string, posterURL != "N/A" else {
            return nil
        }
        
        self.movieID = movieID
        self.posterURL = posterURL
    }
}

final class MoviePosterDataSource {
    
    private var movies = [MoviePoster]() {
        didSet {
            delegate?.didLoadMovieData()
        }
    }
    
    private let networkService = NetworkService()
    
    weak var delegate: MovieDataSourceDelegate?
    
    var numberOfMovies: Int {
        return movies.count
    }
    
    func movie(atIndex indexPath: IndexPath) -> MoviePoster {
        return movies[indexPath.row]
    }

    func fetchMovies(withTitle title: String) {
        networkService.fetchMovies(withTitle: title) { (movies, error) in
            if let _ = error {
                return
            }
            
            self.movies = movies
        }
    }
    
}
