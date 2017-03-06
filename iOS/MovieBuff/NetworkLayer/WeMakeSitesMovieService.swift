//
//  OMDBService.swift
//  MovieBuff
//
//  Created by Mahendra on 16/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//
//API key - TMDB a616b8ad0381bcd02d5d62f5ab353603
import Foundation
import Moya

class weMakeSitesService : MovieServiceProtocol {
    func getSearchResults(searchString: String, completion: @escaping (([[BaseFilmModel]]?,NSError?) -> Void)) {
        let serviceProvider = MoyaProvider<weMakeSitesIMDBService>()
        serviceProvider.request(.getMoviesForActor(actor: searchString)) { result in
            switch result {
            case let .success(moyaResponse) :
                let string1 = String(data: moyaResponse.data, encoding: .utf8)
                print(string1 ?? "test")
                self.parseData(jsonData: moyaResponse.data, completion: completion)
            default :
                break
                
            }
            
        }
    }
    
    
    private func parseData(jsonData : Data,completion:(([[BaseFilmModel]]?,NSError?) -> Void)) {
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
        let code = json??["code"] as? Int
        if(code != 200 ){
            completion(nil,getProperErrorObject(json: json))
        }else{
            completion(buildModelFromJSON(jsonData: jsonData)!, nil)
        }
        return
    }
    
    private func getProperErrorObject(json:[String:Any]??)->NSError {
        let code = json??["code"] as? Int
        let message = json??["message"] as? String
        let userInfo : [NSObject : AnyObject] = [NSLocalizedDescriptionKey as NSObject : NSLocalizedString(message!, comment: "") as AnyObject]
        let error = NSError(domain: "Service Error", code: code!, userInfo: userInfo)
        return error
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


private enum APIKEY {
    static let wemakeSitesKey = "fb355194-1ecb-46c6-954e-49c553216554"//"8d37d5a0-e106-4d66-b78b-83bf3fa4fbef"
}
private enum weMakeSitesIMDBService {
    case getMoviesForActor(actor:String)
}

extension weMakeSitesIMDBService : TargetType {
    var baseURL : URL {return URL(string:"http://imdb.wemakesites.net/api")!}
    var path : String {
        switch self {
        case .getMoviesForActor( _):
            let queryString = "search"
            return queryString
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMoviesForActor:
            return .get
        
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getMoviesForActor(let actor):
            return ["q":actor,"api_key":APIKEY.wemakeSitesKey]
        }
    }
    
    var sampleData : Data {
        switch self{
        case .getMoviesForActor(let actor):
            return actor.data(using: .utf8)!
        }
    }
    
    var parameterEncoding : ParameterEncoding {
        switch self {
        case .getMoviesForActor:
            return URLEncoding.default
        }
    }
    
    var task : Task {
        switch self{
        case .getMoviesForActor:
            return .request
            
        }
    }
}
