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
    
    case movie(title: String)
    
    var method: HTTPMethod {
        switch self {
        case .movie:
            return .get
        }
    }
     
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .movie(let title):
                return ["t" : title]
            }
        }()
        
        let url = try Router.baseURL.asURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return try URLEncoding.default.encode(request, with: parameters)
    }
     
}
