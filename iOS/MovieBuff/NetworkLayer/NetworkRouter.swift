//
//  NetworkRouter.swift
//  MovieBuff
//
//  Created by nimma01 on 19/11/19.
//  Copyright © 2019 Mahendra. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(from route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkResponse:String,Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

class Router<EndPoint : EndPointType> : NetworkRouter {
    private var task :URLSessionTask?
    
    func request(from route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            //revisit this design of new ing an object
            let request = try HTTPRequestBuilder().buildHTTPRequest(from :route)
            task = session.dataTask(with: request, completionHandler: {data, response, error in
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil,nil,NetworkResponse.noData)
                            return
                        }
                        
                        completion(responseData,response,nil)
                    
                    case .failure(let networkFailureError):
                        completion(nil,nil,networkFailureError as? Error)
                    }
                    
                }
            })
        } catch {
            completion(nil,nil,error)
        }
        
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    
}


