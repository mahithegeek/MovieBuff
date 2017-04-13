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
        guard let posterFilePath = self.movie.getposterFilePath() else{
            downloadPoster(completion: completion)
            return
        }
        let filePath = String(describing: DataController.sharedInstance.getMovieAbsoluteFileURL(movie: self.movie))
        print(filePath)
        if FileManager.default.fileExists(atPath: filePath){
            print("Yes")
        }
        let image = UIImage(contentsOfFile: String(describing: DataController.sharedInstance.getMovieAbsoluteFileURL(movie: self.movie)))
        completion(image)
        return
    }
    
    private func downloadPoster(completion:@escaping (UIImage?)->Void){
        
        func onMovieDownload(image:UIImage?){
            DataController.sharedInstance.saveMoviePosterImage(movie: self.movie, downloadedImage: image!)
            completion(image)
        }
        
        MovieHelper().downloadPosterImage(movie: self.movie, completion: onMovieDownload)
    }
    
    func getMovieTitle()->String?{
        return self.movie.getTitleString()
    }
    
    func saveMovie()->Bool{
       return DataController.sharedInstance.addMovieToWatchList(movie: self.movie)
    }
}
