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
    case tmdbService
    case iTunesService
}

extension providerType {
        var getServiceObject:MovieServiceProtocol {
            switch self{
            case .weMakeSites:
                return weMakeSitesService()
            case .tmdbService :
                return TMDBService()
            case .iTunesService :
                return ITunesService()
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
    
    public func searchMovies (searchString : String,completion : @escaping ([Movie]?,NSError?)->Void) {
        self.movieService.searchMovies(searchString: searchString, completion: completion)
    }
    
}
