//
//  MovieDetailsViewModel.swift
//  MovieBuff
//
//  Created by Mahendra on 03/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import UIKit
class MovieDetailsViewModel {
    private var movie:Movie
    
    init(movie : Movie){
        self.movie = movie
    }
    
    func getPosterImage(completion : @escaping (UIImage?)->Void) {
        DispatchQueue.global().async {
            guard let posterPath: String  = self.movie.getposterPath() else{
                completion(nil)
                return
            }
            let urlString = "https://image.tmdb.org/t/p/original" + posterPath
            let url = NSURL(string: urlString)
            guard let data = try? Data(contentsOf: url as! URL) else{
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image!)
        }
    }
    
    func getMovieTitle()->String?{
        return self.movie.getTitleString()
    }
    
    func saveMovie()->Bool{
       return DataController.sharedInstance.addMovieToWatchList(movie: self.movie)
    }
}
