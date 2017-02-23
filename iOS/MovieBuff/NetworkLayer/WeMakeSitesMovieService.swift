//
//  OMDBService.swift
//  MovieBuff
//
//  Created by Mahendra on 16/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import Moya

class weMakeSitesService : MovieServiceProtocol {
    func getSearchResults(searchString: String, completion: @escaping ((Data,NSError?) -> Void)) {
        let serviceProvider = MoyaProvider<weMakeSitesIMDBService>()
        serviceProvider.request(.getMoviesForActor(actor: "Tom Cruise")) { result in
            switch result {
            case let .success(moyaResponse) :
                completion(moyaResponse.data,nil)
            default :
                break
                
            }
            
        }
    }
}


private enum APIKEY {
    static let wemakeSitesKey = "8d37d5a0-e106-4d66-b78b-83bf3fa4fbef"
}
private enum weMakeSitesIMDBService {
    case getMoviesForActor(actor:String)
}

extension weMakeSitesIMDBService : TargetType {
    var baseURL : URL {return URL(string:"http://imdb.wemakesites.net/api")!}
    var path : String {
        switch self {
        case .getMoviesForActor( _):
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
        case .getMoviesForActor(let actor):
            return ["q":actor,"api_key":APIKEY.wemakeSitesKey]
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
