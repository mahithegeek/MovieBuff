//
//  MovieDataProvider.swift
//  MovieBuff
//
//  Created by Mahendra on 22/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation

enum providerType {
    case weMakeSites
}

extension providerType {
        var getServiceObject:weMakeSitesService {
            switch self{
            case .weMakeSites:
                return weMakeSitesService()
        }
    }
    
}

class MovieDataprovider  {
    private var movieService : MovieServiceProtocol
    init(provider:providerType){
        self.movieService = provider.getServiceObject
    }
    
    public func getSearchResults(searchString : String,completion:@escaping (([[BaseFilmModel]]??,NSError?)->Void)){
        self.movieService.getSearchResults(searchString: searchString, completion: completion)
    }
    
}
