//
//  URLParameterEncoding.swift
//  MovieBuff
//
//  Created by nimma01 on 18/11/19.
//  Copyright © 2019 Mahendra. All rights reserved.
//

import Foundation
public struct URLParameterEncoder : ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {throw ParameterEncoderError.missingURL }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters.map { (arg) -> URLQueryItem in
            
            let (key, value) = arg
            return URLQueryItem(name:key,value: value)
            
        }
        
        urlRequest.url = urlComponents?.url
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}
