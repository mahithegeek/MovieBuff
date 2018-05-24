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
        let defaultSession = URLSession(configuration: .default)
        guard let url = URL(string: endPoint)
            else{
                return
        }
        var dataTask: URLSessionDataTask?
            dataTask = defaultSession.dataTask(with: url){data, response, error in
            
                if let error = error {
                    completion(nil,error)
                } else if let data = data,
                    let response = response as? HTTPURLResponse{
                    completion(data,nil)
                }
        }
        
        dataTask?.resume()
        
    }
}
