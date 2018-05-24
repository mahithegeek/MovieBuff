//
//  MovieSearchViewModel.swift
//  MovieBuff
//
//  Created by Mahendra on 10/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import CoreData


class MovieSearchViewModel : NSObject {
    private var movies : [NSManagedObject]
    
    init(movies:[Movie]){
        self.movies = movies
    }
    
    
    func searchMovies (searchString : String,completion:@escaping ([Movie]?,NSError?)->Void) {
        let dataProvider = MovieDataprovider(provider: providerType.iTunesService)
        dataProvider.searchMovies(searchString: searchString, completion: completion)
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
}
