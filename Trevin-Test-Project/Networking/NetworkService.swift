//
//  AdvertisementService.swift
//  Ad-Collector-Test-Project
//
//  Created by Trevin Wisaksana on 17/03/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import SwiftyJSON
import Alamofire

class NetworkService {
    
    // MARK: - Fetching Movies
    
    func fetchMovies(withTitle title: String, atPage page: Int = 1, completion: @escaping (([MoviePoster], Error?) -> Void)) {
        let movieURL = Router.search(movie: title, page: page)
        
        Alamofire.request(movieURL).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                guard let jsonArray = JSON(data)["Search"].array else {
                    return
                }
                
                let movies = jsonArray.compactMap { MoviePoster(json: $0) }
                
                completion(movies, nil)
                
            case .failure(let error):
                completion([MoviePoster](), error)
            }
        }
    }
    
    func fetchMovie(withID id: String, completion: @escaping ((MovieDetail?, Error?) -> Void)) {
        let movieURL = Router.movie(id: id)
        
        Alamofire.request(movieURL).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                let movie = MovieDetail(json: JSON(data))
                
                completion(movie, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

}
