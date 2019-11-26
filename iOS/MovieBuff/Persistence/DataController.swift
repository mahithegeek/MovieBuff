//
//  DataController.swift
//  MovieBuff
//
//  Created by Mahendra on 27/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import CoreData
import UIKit

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
        
        //DispatchQueue.global(qos: .background).async {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            
            let docURL = urls[urls.endIndex - 1]
            
            let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
            do{
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            }catch {
                fatalError("Error migrating store : \(error)")
            }
            
        //}
    }
    
    func getContext()->NSManagedObjectContext {
        return self.managedObjectContext
    }
    
   
    
    func addMovieToWatchList (movie : MovieCoreDataObject)->Bool {
        let movieToSave = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: self.managedObjectContext) as! MovieCoreDataObject
        movieToSave.title = movie.title
        movieToSave.id = movie.id
        movieToSave.overView = movie.overView
        movieToSave.posterPath = movie.posterPath
        movieToSave.posterFilePath = movie.posterFilePath
        
        do{
            try self.managedObjectContext.save()
        } catch _ as NSError {
            return false
        }
        
        return true
        
    }
    
    func getMovieWatchList()->[MovieCoreDataObject] {
        let moviesFetch = NSFetchRequest<NSManagedObject>(entityName: "MovieCoreDataObject")
        var fetchedMovies : [MovieCoreDataObject]
        
        do {
            fetchedMovies = try self.managedObjectContext.fetch(moviesFetch) as! [MovieCoreDataObject]
        } catch {
            fatalError("Failed to fetch Movies: \(error)")
        }
        
        return fetchedMovies
    }
    
    //MARK - Model methods
    func createMovieObjectWithJSON(json:[String : Any])->MovieCoreDataObject {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = self.managedObjectContext
        let movie = MovieCoreDataObject(json: json, context: childContext)
        return movie
    }
    
    func saveMoviePosterImage(movie:MovieCoreDataObject,downloadedImage:UIImage)->Bool{
        guard let imageData = downloadedImage.jpegData(compressionQuality: 1.0) else{
            return false
        }
        let fileName = getDocumentsDirectory().appendingPathComponent(getRelativePath(id: movie.getID()))
        print("Writing the image to disk at location : \(fileName)")
        try? imageData.write(to: fileName)
        movie.setPosterFilePath(filePath: getRelativePath(id: movie.getID()))
        return true
    }
    
    func getMovieAbsoluteFileURL(movieFilePath : String)->URL{
        //print(getDocumentsDirectory() .appendingPathComponent(movieFilePath))
        return getDocumentsDirectory() .appendingPathComponent(movieFilePath)
    }
    
    private func getRelativePath(id:String)->String {
        let relativePath = id + ".jpeg"
        return relativePath
    }
    private func getDocumentsDirectory()->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return paths
    }
    
    
    
}
