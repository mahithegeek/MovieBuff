//
//  MovieServiceProtocol.swift
//  MovieBuff
//
//  Created by Mahendra on 22/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation

public enum ServiceError : String, Error{
    case invalidSearchString = "Invalid Search String"
    
}

protocol MovieServiceProtocol {
    
    func searchMovies (searchString:String, completion: @escaping ([Movie]?,Error?)->Void)
    
}
