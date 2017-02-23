//
//  MovieDataProvider.swift
//  MovieBuff
//
//  Created by Mahendra on 22/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
class MovieDataprovider  {
    private var movieService : MovieServiceProtocol
    init(movieService:MovieServiceProtocol){
        self.movieService = movieService
    }
    
    public func getSearchResults(searchString : String,completion:@escaping (([[BaseFilmModel]],NSError?)->Void)){
        
        func completionHandler(jsonData:Data, error:NSError?)->Void{
            print("Data received is \(String(data:jsonData,encoding:.utf8))")
            completion(buildModelFromJSON(jsonData: jsonData)!, nil)
            
        }
        let searchHandler = completionHandler
        self.movieService.getSearchResults(searchString: searchString, completion: searchHandler)
    }
    
    
    private func buildModelFromJSON(jsonData : Data)->[[BaseFilmModel]]? {
        var array  = [[BaseFilmModel]]()
        let data = jsonData
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        guard let dataField = json??["data"] as? [String:Any],
        let results = dataField["results"] as? [String:Any],
        let names = results["names"] as? [[String:Any]],
        let titles = results["titles"] as? [[String:Any]]
            else{
                print("error")
                return nil
        }
        
        let namesArray = buildActors(namesJson: names)
        let titlesArray = buildTitles(titlesJson: titles)
        
        array.append(namesArray)
        array.append(titlesArray)
    
        return array
    }
    
    private func buildActors(namesJson:[[String:Any]])->[Actor] {
        var namesArray = [Actor]()
        for name in namesJson {
            namesArray.append(Actor(json: name)!)
        }
        print("count is \(namesArray.count)")
        return namesArray
    }
    
    private func buildTitles(titlesJson:[[String:Any]])->[Title] {
        var titlesArray = [Title]()
        for title in titlesJson {
            titlesArray.append(Title(json: title)!)
        }
        print("count is \(titlesArray.count)")
        return titlesArray
    }
    
}
