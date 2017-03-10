//
//  MovieSearchViewModel.swift
//  MovieBuff
//
//  Created by Mahendra on 10/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation

class MovieSearchViewModel {
    private var movies : [Movie]
    
    init(movies:[Movie]){
        self.movies = movies
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
        
        return self.movies[row]
    }
    
    func updateModel(movies:[Movie]){
        self.movies = movies
    }
    
    func getSelectedRowObject(row:Int)->Movie {
        return self.movies[row]
    }
}
