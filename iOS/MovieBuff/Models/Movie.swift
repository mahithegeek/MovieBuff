//
//  Movie.swift
//  MovieBuff
//
//  Created by nimma01 on 08/11/19.
//  Copyright © 2019 Mahendra. All rights reserved.
//

import Foundation

struct MovieAPIResponse {
    let numberOfResults : Int
    let movies : [Movie]
}

extension MovieAPIResponse : Decodable {
    private enum MovieAPIResponseCodingKeys : String, CodingKey {
        case numberOfResults = "resultCount"
        case movies = "results"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: MovieAPIResponseCodingKeys.self)
        
       numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
}

struct Movie {
     let id : Int
     let title : String
     let posterPath : String
     let overView : String
     
}

extension Movie : Decodable {
    
    private enum MovieCodingKeys : String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case posterPath = "artworkUrl100"
        case overView = "longDescription"
        
    }
    
    init(from decoder:Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try movieContainer.decode(Int.self, forKey: .id)
        title = try movieContainer.decode(String.self, forKey: .title)
        //Strange that iTunes API doesnot give this ... little hack
        posterPath = try movieContainer.decode(String.self, forKey: .posterPath).replacingOccurrences(of: "100x100bb", with: "600x600bb")
        overView = try movieContainer.decode(String.self, forKey: .overView)
    }
    
    
}
