//
//  MovieSearchViewModel.swift
//  MovieBuff
//
//  Created by Mahendra on 10/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol MovieSearchViewModelView:AnyObject {
    func reloadView()
}
class MovieSearchViewModel : NSObject,ImageTaskDownloader {
    private var movies : [NSManagedObject]
    private var imageTasks = [Int:ImageTask]()
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    var imageCompletionHandler  = [Int:((UIImage?)->Void)]()
    weak var delegate : MovieSearchViewModelView?
    init(movies:[Movie]){
        self.movies = movies
    }
    
    
    func searchMovies (searchString : String,completion:@escaping ([Movie]?,NSError?)->Void) {
        clearOldSearch()
        let dataProvider = MovieDataprovider(provider: providerType.iTunesService)
        dataProvider.searchMovies(searchString: searchString, completion: completion)
    }
    
    func clearOldSearch () {
        self.imageTasks.removeAll()
        self.imageCompletionHandler.removeAll()
        self.delegate?.reloadView()
        
    }
    
    //TO-Do make it powerful
    func numberOfSections()->Int{
        return 1;
    }
    
    func sectionTitle(sectionNumber : Int) -> String{
        var result = ""
        switch sectionNumber {
        case 0:
            result =  "Movies"
        case 1:
            result =  "Actors"
        default:
            result = ""
        }
        
        return result
    }
    
    func numberOfRowsForModel(sectionNumber : Int) -> Int {
        var result = 1
        
        switch sectionNumber {
        case 0:
            result = (self.movies.count)
        default:
            return 1
            
        }
        
        
        return result
    }
    
    func modelForCell (section:Int,row:Int) -> Movie? {
        
        if(self.movies.count == 0){
            return nil
        }
        return self.movies[row] as? Movie
    }
    
    
    func updateModel(movies:[Movie]){
        self.movies = movies
        print("count after \(self.movies.count)")
    }
    
    func getSelectedRowObject(row:Int)->Movie {
        return (self.movies[row] as? Movie)!
    }
    
    
    func imageForCell(section:Int,row:Int,completion:@escaping (UIImage?)->Void) -> Void {
        
        guard let imageTask = self.imageTasks[row]
            else{
                guard let movieObject = modelForCell(section: section, row: row)
                    else{
                        completion(nil)
                        return
                }
                
                guard let posterURLString = movieObject.posterPath
                    else{
                        completion(nil)
                        return
                }
                guard let posterURL = URL(string: posterURLString)
                    else{
                        completion(nil)
                        return
                }
                setupImageTask(position: row, url: posterURL)
                imageCompletionHandler[row] = completion
                return
        }
        
        completion(imageTask.image)
        
    }
    
    func willDisplayCell(section:Int,row:Int){
        self.imageTasks[row]?.resume()
    }
    
    func didEndDisplay(section:Int,row:Int) {
        self.imageTasks[row]?.pause()
    }
    
    private func setupImageTask(position:Int,url:URL){
        let imageTask = ImageTask(position: position, url: url, session: self.session, delegate: self)
        self.imageTasks[position] = imageTask
        print("Setting up image download for image \(url) count of tasks \(self.imageTasks.count)")
    }
    
    func imageDownloaded(position: Int,image: UIImage) {
        print("Image downloaded for position \(position)")
        imageCompletionHandler[position]!(image)
    }
}
