//
//  iTunesMovieAPI.swift
//  MovieBuff
//
//  Created by nimma01 on 22/11/19.
//  Copyright © 2019 Mahendra. All rights reserved.
//

import Foundation

//public enum iTunesMovieApi {
//    case name(movie:String)
//}
//
//extension iTunesMovieApi : EndPointType {
//    var baseURL: String {
//        let url = "https://itunes.apple.com/"
//        return url
//    }
//
//    var path : String {
//        let path = "search"
//        return path
//    }
//
//    var httpMethod: HTTPMethod {
//        return .GET
//    }
//
//    var headers: HTTPHeaders? {
//        return nil
//    }
//
//    var parameters: HTTPHeaders? {
//        switch self {
//        case .name(let movie):
//            let parameters = ["term":movie,"media":"movie"]
//            return parameters
//        }
//    }
//}

public struct iTunesMovieAPI : EndPointType {
    var movieSearchString : String!
    init(movie:String){
        movieSearchString = movie
    }
    var baseURL: String {
        let url = "https://itunes.apple.com"
        return url
    }

    var path : String {
        let path = "/search"
        return path
    }

    var httpMethod: HTTPMethod {
        return .GET
    }

    var headers: HTTPHeaders? {
        return nil
    }

    var parameters: HTTPHeaders? {
        let parameters = ["term":movieSearchString!,"media":"movie"]
        return parameters
    }
}

