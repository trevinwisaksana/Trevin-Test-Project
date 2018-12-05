//
//  AdvertisementService.swift
//  Ad-Collector-Test-Project
//
//  Created by Trevin Wisaksana on 17/03/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import SwiftyJSON
import Alamofire

protocol NetworkServiceDelegate: class {
    
}

struct NetworkService {
    
    // MARK: - Fetching Movies
    
    func fetchMovie(withTitle title: String, completion: @escaping (([Movie], Error?) -> Void)) {
        let movieURL = Router.movie(title: title)
            
        Alamofire.request(movieURL).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                guard let jsonArray = JSON(data)["Search"].array else {
                    return
                }
                
                let movies = jsonArray.compactMap { Movie(json: $0) }
                
                completion(movies, nil)
                
            case .failure(let error):
                completion([Movie](), error)
            }
        }
    }

}
