//
//  ParameterEncoding.swift
//  MovieBuff
//
//  Created by nimma01 on 18/11/19.
//  Copyright © 2019 Mahendra. All rights reserved.
//

import Foundation

public typealias Parameters = [String:String]

public protocol ParameterEncoder {
    func encode(urlRequest : inout URLRequest,with parameters:Parameters) throws
}

public enum ParameterEncoderError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
    
    public  func encode (urlRequest: inout URLRequest,
                        bodyParameters:Parameters?,
                        urlParameters:Parameters?) throws {
        do{
            switch self {
            case .urlEncoding:
                guard let urlParameters = bodyParameters
                    else {return}
                
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else{return}
                
                //try 
            default:
                print("no default")
            }
        }
    }
}
