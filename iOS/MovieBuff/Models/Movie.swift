//
//  Movie.swift
//  MovieBuff
//
//  Created by Mahendra on 09/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
class Movie {
    
    private var title : String?
    private var id : String?
    private var overview : String?
    private var releaseDate : Date?
    private var posterPath : String?
    
    var getTitle : String? {
        get{
            return self.title
        }
    }
    
    var getPosterPath : String? {
        get{
            return self.posterPath
        }
    }
    
    init?(json:[String : Any]){
        self.title = (json["title"] as? String)
        self.id = json["id"] as? String
        self.overview = json["overview"] as? String
        self.posterPath = json["poster_path"] as? String
    }
}
