//
//  EndPoint.swift
//  MovieBuff
//
//  Created by nimma01 on 18/11/19.
//  Copyright © 2019 Mahendra. All rights reserved.
//

import Foundation

public enum HTTPMethod : String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}

public typealias HTTPHeaders = [String:String]

protocol EndPointType {
    var baseURL : String {get }
    var path : String {get}
    var httpMethod : HTTPMethod {get}
    var headers : HTTPHeaders? {get}
    var parameters : HTTPHeaders? { get }
}
