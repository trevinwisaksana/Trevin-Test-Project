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
    
    func fetchMovie(withTitle title: String, success: @escaping SuccessOperationClosure) {
        let movieURL = Router.movie(title: title)
            
        Alamofire.request(movieURL).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                success(true)
            case .failure:
                success(false)
            }
        }
    }

}
