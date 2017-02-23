//
//  Actor.swift
//  MovieBuff
//
//  Created by Mahendra on 21/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation

class Actor:BaseFilmModel {
    
    private var resourceUrl : String
    private var thumbNailUrl : String
    
    var getResourceUrl : String {
        return resourceUrl
    }
    var getThumbNailUrl : String {
        return thumbNailUrl
    }
    
    init(title:String,id:String,url:String,thumbNail : String){
        self.resourceUrl = url
        self.thumbNailUrl = thumbNail
        super.init(title: title, id: id)
        
    }
    
    init?(json:[String:Any]) {
        guard let title = json["title"] as? String,
            let Id = json["id"] as? String,
            let url = json["url"] as? String,
            let thumbNailURL = json["thumbnail"] as? String
            
            else{
                return nil
        }
        
        self.resourceUrl = url
        self.thumbNailUrl = thumbNailURL
        super.init(title: title, id: Id)
    }
}
