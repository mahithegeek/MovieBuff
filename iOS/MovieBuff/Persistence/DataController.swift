//
//  DataController.swift
//  MovieBuff
//
//  Created by Mahendra on 27/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import CoreData

class DataController : NSObject {
    var managedObjectContext : NSManagedObjectContext
    static let sharedInstance = DataController()
    private override init() {
        guard let modelURL =  Bundle.main.url(forResource: "MovieBuff", withExtension:"momd")  else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else{
            fatalError("Error initializing mom from : \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc
        
        DispatchQueue.global(qos: .background).async {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            
            let docURL = urls[urls.endIndex - 1]
            
            let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
            do{
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            }catch {
                fatalError("Error migrating store : \(error)")
            }
            
        }
    }
    
    func getContext()->NSManagedObjectContext {
        return self.managedObjectContext
    }
    
   /* func addToWatchList(movie : Movie)->Bool {
        
    }*/
    
    func addMovieToWatchList (movie : Movie)->Bool {
        let movieToSave = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: self.managedObjectContext) as! Movie
        movieToSave.title = movie.title
        
        do{
            try self.managedObjectContext.save()
        } catch _ as NSError {
            return false
        }
        
        return true
        
    }
    
    //MARK - Model methods
    func createMovieObjectWithJSON(json:[String : Any])->Movie {
        print(self.managedObjectContext)
        
        let movie = Movie(json: json, context: self.managedObjectContext)
        
         return movie
    }
    
}
