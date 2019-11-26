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
        
//        guard let posterFilePath = self.movie.posterPath else{
//            downloadPoster(completion: completion)
//            return
//        }
//        //let filePath = String(describing: DataController.sharedInstance.getMovieAbsoluteFileURL(movieFilePath: posterFilePath))
//        let filePath = DataController.sharedInstance.getMovieAbsoluteFileURL(movieFilePath: posterFilePath)
//        print(filePath)
//        if FileManager.default.fileExists(atPath: filePath.path){
//            print("Poster Image found")
//            let image = UIImage(contentsOfFile: filePath.path)
//            completion(image)
//            return
//        }
        
        completion(nil)
        return
    }
    
    private func downloadPoster(completion:@escaping (UIImage?)->Void){
        
//        func onMovieDownload(image:UIImage?){
//            if image != nil && !DataController.sharedInstance.saveMoviePosterImage(movie: self.movie, downloadedImage: image!){
//                print("Unable to save poster image")
//            }
//            completion(image)
//        }
//
//        MovieHelper().downloadPosterImage(movie: self.movie, completion: onMovieDownload)
    }
    
    func getMovieTitle()->String?{
        return self.movie.title
    }
    
    func getMovieOverView()->String? {
        return self.movie.overView
    }
    
    func saveMovie()->Bool{
       
        return false//return DataController.sharedInstance.addMovieToWatchList(movie: self.movie)
    }
    
    func canShowSaveMovie()->Bool{
        return false
        //return !self.movie.isMovieSaved()
    }
}
