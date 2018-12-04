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
    
    static let baseURL: String = "https://api.github.com"
    
    case userGists(String)
    case star(String)
    case publicGists
    case unstar(String)
    case getStarredGists
    case createGist([String : Any])
    
    var method: HTTPMethod {
        switch self {
        case .userGists, .publicGists, .getStarredGists:
            return .get
        case .star:
            return .put
        case .unstar:
            return .delete
        case .createGist:
            return .post
        }
    }

    var path: String {
        switch self {
        case .userGists(let username):
            return "/users/\(username)/gists"
        case .star(let id):
            return "/gists/\(id)/star"
        case .unstar(let id):
            return "/gists/\(id)/unstar"
        case .publicGists:
            return "/gists/public"
        case .getStarredGists:
            return "/gists/starred"
        case .createGist:
            return "/gists"
        }
    }
    
    
    public func asURLRequest() throws -> URLRequest {
        
        let parameters: [String: Any] = {
            switch self {
            case .userGists:
                
                let formatter = ISO8601DateFormatter()
                guard let date = formatter.date(from: "2015-03-01T18:49:24Z") else {
                    return ["since": Date()]
                }
            
                return ["since" : date]
                
            case .star, .publicGists, .unstar, .getStarredGists:
                return [:]
            case .createGist(let json):
                return json
            }
        }()
        
        let headers: [String : String] = {
            switch self {
            case .star, .unstar:
                return ["Content-Length" : "0"]
            case .userGists, .getStarredGists:
                return [:]
            default:
                return [:]
            }
        }()
        
        let url = try Router.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        switch self {
        case .createGist:
            return try JSONEncoding.default.encode(request, with: parameters)
        default:
            return try URLEncoding.default.encode(request, with: parameters)
        }
        
    }
     
}



