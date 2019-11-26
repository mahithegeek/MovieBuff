//
//  ITunesService.swift
//  MovieBuff
//
//  Created by nimma01 on 24/05/18.
//  Copyright © 2018 Mahendra. All rights reserved.
//

import UIKit

class ITunesService: MovieServiceProtocol {
    
//    func searchMovies(searchString: String, completion: @escaping ([Movie]?, NSError?) -> Void) {
//        let networkManager = NetworkManager()
//        func handler(data:Data?,error:Error?)->Void{
//            guard let jsonData = data
//                else{
//                    completion(nil,error as NSError?)
//                    return
//            }
//
//            let movies = parseJSON(data: jsonData)
//            if let error = movies.error{
//                completion(nil,error as NSError?)
//            }
//            else if let movieArray = movies.movies {
//                completion(movieArray,nil)
//            }
//        }
//
//        let endPoint = "https://itunes.apple.com/search?term="+urlEncodeSearchString(searchString: searchString)
//        //"https://itunes.apple.com/search?term=ironman&media=movie"
//        networkManager.postRequest(endPoint:  endPoint, completion: handler)
//    }
    
    func searchMovies(searchString: String, completion: @escaping ([Movie]?, Error?) -> Void) {
        if(searchString.count <= 0){
            completion(nil,ServiceError.invalidSearchString)
        }
        
        let router = Router<iTunesMovieAPI>()
        //ideally do not want response here
        router.request(from: iTunesMovieAPI(movie: searchString), completion: {data,response,error in
            
            if error != nil {
                completion(nil,error)
                return
            }
            
            do {
                print(data)
                guard let responseData = data else {
                    completion(nil,error)
                    return
                }
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(jsonData)
                let apiResponse = try JSONDecoder().decode(MovieAPIResponse.self, from: responseData)
                completion(apiResponse.movies,nil)
            } catch{
                print(error)
            }
        })
        
        
    }
    
    
    
    func urlEncodeSearchString(searchString:String)->String{
        return searchString.replacingOccurrences(of: " ", with: "+")
    }
    
    
    
    func parseJSON(data:Data)->(movies:[MovieCoreDataObject]?,error:Error?){
        var response : [String:Any]?
        do{
            response =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            print(response ?? "parseJSON: Nil response received")
        } catch let parseError {
            //error
            return (nil,parseError)
        }
        
        guard let array = response!["results"] as? [[String:Any]] else{
            //TODO form proper error
            return (nil,nil)
        }
        
        
        
        var movieObjectsArray = [MovieCoreDataObject]()
        
        for movie in array {
            guard let kind : String = movie["kind"] as? String
                else{
                    continue
            }
            
            if(kind == "feature-movie") {
                let movieObject = MovieCoreDataObject(context: nil)
                // movieObject.overView = movie["longDescription"] as? String
                movieObject.setValue(movie["trackName"], forKey: "title")
                movieObject.setValue((movie["trackId"]), forKey: "id")
                movieObject.setValue(getEnhancedThumbNailURL(artWorkurl: movie["artworkUrl100"]! as! String) , forKey: "posterPath")
                //movieObject.setValue( movie["collectionViewUrl"]  , forKey: "posterPath")
                //guard let posterPath =
                //movieObject.setValue("https://is5-ssl.mzstatic.com/image/thumb/Video118/v4/02/0e/c9/020ec98b-f4b3-05e9-2de3-5e7d0363b298/source/600x600bb.jpg", forKey: "posterPath")
                movieObject.setValue(movie["longDescription"], forKey: "overView")
                movieObjectsArray.append(movieObject)
            }
            
        }
        return (movieObjectsArray,nil)
        
    }
    
    func getEnhancedThumbNailURL(artWorkurl:String)->String {
        let artWorkURL600 = artWorkurl.replacingOccurrences(of: "100x100bb", with: "600x600bb")
        return artWorkURL600
    }
}
