//
//  ITunesService.swift
//  MovieBuff
//
//  Created by nimma01 on 24/05/18.
//  Copyright © 2018 Mahendra. All rights reserved.
//

import UIKit

class ITunesService: MovieServiceProtocol {
    
    func searchMovies(searchString: String, completion: @escaping ([Movie]?, NSError?) -> Void) {
        let networkManager = NetworkManager()
        
        func handler(data:Data?,error:Error?)->Void{
            //print(data)
            guard let jsonData = data
                else{
                    return
            }
            
            parseJSON(data: jsonData)
        }
        networkManager.postRequest(endPoint:  "https://itunes.apple.com/search?term=ironman&media=movie", completion: handler)
    }
    
    func getSearchResults(searchString: String, completion: @escaping (([[BaseFilmModel]]?, NSError?) -> Void)) {
        //
    }
    
    
    func parseJSON(data:Data)->[String:Any]?{
        var response : [String:Any]?
        do{
            response =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        } catch let parseError as NSError {
            //error
        }
        
        guard let array = response!["results"] as? [[String:Any]] else{
            return nil
        }
        
        var movieArray = [Movie]()
        for movie in array {
            let movieObject = Movie()
            movieObject.overView = movie["longDescription"] as? String
            movieArray.append(movieObject)
        }
        
        
        return response
        
    }
}
