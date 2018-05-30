//
//  NetworkManager.swift
//  MovieBuff
//
//  Created by nimma01 on 24/05/18.
//  Copyright © 2018 Mahendra. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func postRequest(endPoint:String,completion: @escaping(Data?,Error?)->Void){
        guard let url = URL(string: endPoint)
            else{
                return
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let dataSession = URLSession(configuration: configuration)
        
        let dataTask = dataSession.dataTask(with: url){data, response, error in
        
            if let error = error {
                completion(nil,error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion(nil,error)
                    return
            }
            if let data = data {
                completion(data,nil)
            }
        }
        //dataTask.defa
        dataTask.resume()
    }
}
