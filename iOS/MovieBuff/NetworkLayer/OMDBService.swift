//
//  OMDBService.swift
//  MovieBuff
//
//  Created by Mahendra on 16/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import Moya

enum weMakeSitesService {
    case getMoviesForActor(actor:String)
}

extension weMakeSitesService : TargetType {
    var baseURL : URL {return URL(string:"http://imdb.wemakesites.net/api")!}
    var path : String {
        switch self {
        case .getMoviesForActor( _):
            //let queryString = "q=\(actor)&api_key=8d37d5a0-e106-4d66-b78b-83bf3fa4fbef"
            //let queryString = "nm0000115"
            let queryString = "search"
            return queryString
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMoviesForActor:
            return .get
        
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getMoviesForActor:
            return ["q":"Robert","api_key":"8d37d5a0-e106-4d66-b78b-83bf3fa4fbef"]
        }
    }
    
    var sampleData : Data {
        switch self{
        case .getMoviesForActor(let actor):
            return actor.data(using: .utf8)!
        }
    }
    
    var parameterEncoding : ParameterEncoding {
        switch self {
        case .getMoviesForActor:
            return URLEncoding.default
        }
    }
    
    var task : Task {
        switch self{
        case .getMoviesForActor:
            return .request
            
        }
    }
}
