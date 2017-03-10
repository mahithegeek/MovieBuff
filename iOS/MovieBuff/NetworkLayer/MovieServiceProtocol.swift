//
//  MovieServiceProtocol.swift
//  MovieBuff
//
//  Created by Mahendra on 22/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
    func getSearchResults (searchString:String,completion: @escaping (([[BaseFilmModel]]?,NSError?)->Void))
    func searchMovies (searchString:String, completion: @escaping ([Movie]?,NSError?)->Void)
}
