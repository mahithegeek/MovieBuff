//
//  Movie.swift
//  MovieBuff
//
//  Created by Mahendra on 04/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import CoreData
class Movie : NSManagedObject{
    @NSManaged var id : String?
    @NSManaged var title : String?
    @NSManaged var posterPath : String?
    @NSManaged var overView : String?
    
    convenience init(json:[String:Any],context:NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)
        self.init(entity: entity!, insertInto: context)
        constructWIthJSON(json: json)
        
        
    }
    
    func getposterPath()->String?{
        return self.value(forKey: "posterPath") as? String
    }
    
    func getTitleString()->String? {
        return self.value(forKey: "title") as? String
    }
    
    private func constructWIthJSON(json:[String:Any]){
        //TODO can we do better??
        var title = json["title"]
        
        if(title == nil){
            title = ""
        }
        self.setValue(title, forKey: "title")
        
        
        let id = String(describing:json["id"])
        self.setValue(id, forKey: "id")
        
        
        var posterPath = json["poster_path"]
        if posterPath is NSNull {
            posterPath = ""
        }
        self.setValue(posterPath, forKey: "posterPath")
        
        var overView = json["overview"]
        
        if(overView == nil) {
            overView = ""
        }
        self.setValue(overView, forKey: "overView")
    }
}
