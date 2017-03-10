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
    func buildMovieModelFromJSON(jsonData : Data) throws ->[Movie]{
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
        
        guard let results = json??["results"] as? [[String : Any]]
            else{
                throw TMDBParserError.invalidJSON
        }
        
        print(results)
        var movieArray =  [Movie]()
        for object in results{
            let temp = Movie(json: object)
            movieArray.append(temp!)
        }
        return movieArray
    }
}
