//
//  MovieDetailsViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 03/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieDetailsViewModel : MovieDetailsViewModel!
    @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateImage(){
        
        func onImageRetrieved(image:UIImage){
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
        }
        self.movieDetailsViewModel.getPosterImage(completion: onImageRetrieved)
    }

}
