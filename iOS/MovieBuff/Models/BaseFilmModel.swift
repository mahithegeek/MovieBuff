//
//  BaseFilmModel.swift
//  MovieBuff
//
//  Created by Mahendra on 21/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation

class BaseFilmModel {
    
    var title : String {
        return modelTitle;
    }
    
    var Id : String {
        return modelId
    }
    
    private var modelTitle:String
    private var modelId : String
    
    init(title:String,id:String){
        self.modelTitle = title
        self.modelId = id
    }
    
    

}
