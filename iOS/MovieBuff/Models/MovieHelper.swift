//
//  MovieHelper.swift
//  MovieBuff
//
//  Created by Mahendra on 13/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import UIKit
class  MovieHelper {
    
    func downloadPosterImage(movie:Movie,completion:@escaping (UIImage?)->Void){
        DispatchQueue.global().async {
            guard let posterPath: String  = movie.getposterPath() else{
                completion(nil)
                return
            }
            let urlString = TMDBService.getPrependingURL() + posterPath
            let url = NSURL(string: urlString)
            guard let data = try? Data(contentsOf: url as! URL) else{
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else{
                completion(nil)
                return
            }
            
            completion(image)
            
        }

    }
}
