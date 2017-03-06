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
    private var title:Title
    
    init(title : Title){
        self.title = title
    }
    
    func getPosterImage(completion : @escaping (UIImage)->Void) {
        DispatchQueue.global().async {
            let url = NSURL(string: self.title.getThumbNailUrl)
            let data = try? Data(contentsOf: url as! URL)
            let image = UIImage(data: data!)
            completion(image!)
        }
    }
}
