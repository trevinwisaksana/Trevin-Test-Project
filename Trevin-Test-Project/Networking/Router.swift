//
//  NetworkService.swift
//  GitProject
//
//  Created by Trevin Wisaksana on 2/17/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Alamofire

public enum Router: URLRequestConvertible {
    
    static let baseURL: String = "http://www.omdbapi.com/?apikey=5a26eb15"
    
    case movie(id: String)
    case search(movie: String, page: Int)
    
    var method: HTTPMethod {
        switch self {
        case .movie, .search:
            return .get
        }
    }
     
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .movie(let id):
                return ["i" : id, "plot": "full"]
            case .search(let movie, let page):
                return ["s" : movie, "page" : page]
            }
        }()
        
        let url = try Router.baseURL.asURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return try URLEncoding.default.encode(request, with: parameters)
    }
     
}
