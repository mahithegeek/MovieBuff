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
    
}
