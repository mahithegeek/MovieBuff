//
//  SearchViewModel.swift
//  MovieBuff
//
//  Created by Mahendra on 23/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation

enum ModelType {
    case Actor
    case Title
}

class SearchViewModel {
    
    private let filmModel : [[BaseFilmModel]]
    private var actorsArray : [Actor]?
    private var titleArray : [Title]?
    
    init(filmModel : [[BaseFilmModel]]){
        self.filmModel = filmModel
        stripModel(model:filmModel)
    }
    
    //To-DO do a better and clean iteration in the array
    private func stripModel(model : [[BaseFilmModel]]){
        self.actorsArray = model[0] as? [Actor]
        self.titleArray = model[1] as? [Title]
    }
    
    //TO-Do make it powerful
    func numberOfSections()->Int{
        return 2;
    }
    
    func numberOfRowsForModel(sectionNumber : Int) -> Int {
        var result = 1
        
        switch sectionNumber {
        case 0:
            result = (self.actorsArray?.count)!
        case 1:
            result = (self.titleArray?.count)!
        default:
            return 1
            
        }
        
        
        return result
    }
    
    func modelForCell (section:Int,row:Int) -> Actor {
        if(section == 0){
            return self.actorsArray![row]
        }
        
        return self.titleArray![row]
        
        
    
    }
}
