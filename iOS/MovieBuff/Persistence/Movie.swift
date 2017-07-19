//
//  Movie.swift
//  MovieBuff
//
//  Created by Mahendra on 04/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class Movie : NSManagedObject{
    @NSManaged var id : String?
    @NSManaged var title : String?
    @NSManaged var posterPath : String?
    @NSManaged var overView : String?
    @NSManaged var posterFilePath : String?
    @NSManaged var rating : String?
    
    convenience init(json:[String:Any],context:NSManagedObjectContext?) {
        var entity : NSEntityDescription?
        if(context == nil){
             entity = NSEntityDescription.entity(forEntityName: "Movie", in: DataController.sharedInstance.getContext())
        }
        else{
            entity = NSEntityDescription.entity(forEntityName: "Movie", in: DataController.sharedInstance.getContext())
        }
        
        self.init(entity: entity!, insertInto: context)
        constructWithTMDBJSON(json: json)
    }
    
    func getposterPath()->String?{
        return self.value(forKey: "posterPath") as? String
    }
    
    func getTitleString()->String? {
        return self.value(forKey: "title") as? String
    }
    func getID()->String {
        return self.value(forKey: "id") as! String
    }
    
    func setPosterFilePath(filePath : String){
        self.setValue(filePath, forKey: "posterFilePath")
    }
    
    func getposterFilePath()->String?{
        return self.value(forKey: "posterFilePath") as? String
    }
    
    func isMovieSaved()->Bool {
        return !self.objectID.isTemporaryID
    }
    
    func getMovieOverView()->String? {
        return self.value(forKey: "overView") as? String
    }
    
    private func constructWithTMDBJSON(json:[String:Any]){
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
        
        var rating = String(describing: json["vote_average"])
        
        if(rating == nil) {
            rating = ""
        }
        self.setValue(rating, forKey: "rating")
    }
}
