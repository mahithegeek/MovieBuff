//
//  TMDBDataParser.swift
//  MovieBuff
//
//  Created by Mahendra on 09/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation

enum TMDBParserError : Error {
    case invalidJSON
}

class TMDBDataParser {
    let dataController : DataController
    
    init(){
        dataController = DataController.sharedInstance
    }
    
    func buildMovieModelFromJSON(jsonData : Data) throws ->[MovieCoreDataObject]{
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
        
        guard let results = json??["results"] as? [[String : Any]]
            else{
                throw TMDBParserError.invalidJSON
        }
        
        print(results)
        var movieArray =  [MovieCoreDataObject]()
        for object in results{
            let temp:MovieCoreDataObject =  createMovieObjectsWithJSON(json: object)
            movieArray.append(temp)
        }
        return movieArray
    }
    
    func createMovieObjectsWithJSON (json:[String:Any])->MovieCoreDataObject{
        return MovieCoreDataObject(json: json, context: nil)
        
    }
}
