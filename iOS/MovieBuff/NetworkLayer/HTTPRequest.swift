//
//  HTTPRequest.swift
//  MovieBuff
//
//  Created by nimma01 on 18/11/19.
//  Copyright © 2019 Mahendra. All rights reserved.
//

import Foundation

struct HTTPRequestBuilder <EndPoint:EndPointType> {
    
      func buildHTTPRequest(from endPoint : EndPoint ) throws ->URLRequest {
        //ideally expose this time out as well
        let urlString = endPoint.baseURL + endPoint.path
        let url = URL(string: urlString)!
        var request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 30)
        
        request.httpMethod = endPoint.httpMethod.rawValue
        
        do{
            switch endPoint.httpMethod {
            case .GET:
                //form url encoding
                
                do{
                    try ParameterEncoding.urlEncoding.encode(urlRequest: &request, bodyParameters: endPoint.parameters, urlParameters: endPoint.headers)
                } catch {
                    //throw error
                    throw error
                }
                
                
            case .POST:
                //form post encoding
                print("Preparing a POST request")
                do{
                    try ParameterEncoding.jsonEncoding.encode(urlRequest: &request, bodyParameters: endPoint.parameters, urlParameters: endPoint.headers)
                } catch {
                    print(error)
                    throw error
                }
                
            default:
                print("default")
            }
        }
        
        return request
    }
    
}
