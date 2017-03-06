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
    
    private var filmModel : [[BaseFilmModel]]??
    private var actorsArray : [Actor]?
    private var titleArray : [Title]?
    
    init(filmModel : [[BaseFilmModel]]??){
        if filmModel != nil{
            self.filmModel = filmModel
            stripModel(model:filmModel!!)
        }
        
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
    
    func sectionTitle(sectionNumber : Int) -> String{
        var result = ""
        switch sectionNumber {
            case 0:
                result =  "Actors"
            case 1:
                result =  "Movies"
            default:
                result = ""
        }
        
        return result
    }
    
    func numberOfRowsForModel(sectionNumber : Int) -> Int {
        var result = 1
        
        switch sectionNumber {
        case 0:
            result = (self.actorsArray != nil) ? (self.actorsArray?.count)! : 1
        case 1:
            result = (self.titleArray != nil) ? (self.titleArray?.count)! : 1
        default:
            return 1
            
        }
        
        
        return result
    }
    
    func modelForCell (section:Int,row:Int) -> Actor? {
        
        if(self.actorsArray == nil){
            return nil
        }
        if(section == 0){
            return self.actorsArray![row]
        }
        
        return self.titleArray![row]
        
        
    
    }
    
    func updateModel(filmModel:[[BaseFilmModel]]){
        self.filmModel = filmModel
        self.stripModel(model: filmModel)
    }
    
    func getSelectedRowObject(row:Int)->Title {
        return self.titleArray![row]
    }
}
