//
//  TMDBService.swift
//  MovieBuff
//
//  Created by Mahendra on 08/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import Moya

class TMDBService : MovieServiceProtocol {
    
    class func getPrependingURL()->String{
        return "https://image.tmdb.org/t/p/original"
    }
    
    func searchMovies(searchString: String, completion: @escaping ([Movie]?, NSError?) -> Void) {
        let serviceProvider = MoyaProvider<TMDBMovieService>()
        serviceProvider.request(.searchMovies(actor: searchString)) { result in
            switch result {
            case let .success(moyaResponse) :
                let string1 = String(data: moyaResponse.data, encoding: .utf8)
                print(string1 ?? "test")
                
                let movies = self.handleMovieSearchResponse(jsonData: moyaResponse.data)
                if(movies != nil){
                    completion(movies,nil)
                }
                
            default :
                break
                
            }
            
        }
    }

    internal func getSearchResults(searchString: String, completion: @escaping (([[BaseFilmModel]]?, NSError?) -> Void)) {
        //not implemented
    }
    
    
    private func handleMovieSearchResponse(jsonData : Data)->[Movie]?{
        let parser = TMDBDataParser()
        let movies : [Movie]?
        
        do {
            movies = try parser.buildMovieModelFromJSON(jsonData: jsonData)
        } catch TMDBParserError.invalidJSON {
            movies = nil
        } catch {
            movies = nil
        }
        
        return movies
    }

}

private enum TMDBMovieService {
    case searchMovies(actor:String)
}

private enum TMDBProperties {
    static let apiKey = "a616b8ad0381bcd02d5d62f5ab353603"
    static let baseURL = "https://api.themoviedb.org/3/"
}

extension TMDBMovieService : TargetType {
    var baseURL : URL {return URL(string:TMDBProperties.baseURL)!}
    var path : String {
        switch self {
        case .searchMovies( _):
            let queryString = "search/movie"
            return queryString
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchMovies:
            return .get
            
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .searchMovies(let movie):
            return ["api_key":TMDBProperties.apiKey,"language":"en-US","query":movie]
        }
    }
    
    var sampleData : Data {
        switch self{
        case .searchMovies(let movie):
            return movie.data(using: .utf8)!
        }
    }
    
    var parameterEncoding : ParameterEncoding {
        switch self {
        case .searchMovies:
            return URLEncoding.default
        }
    }
    
    var task : Task {
        switch self{
        case .searchMovies:
            return .request
            
        }
    }
}
