//
//  MovieDetailsViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 03/03/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
import SwiftSpinner

class MovieDetailsViewController: UIViewController {
    var movieDetailsViewModel : MovieDetailsViewModel!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var movieName : UILabel!
    @IBOutlet weak var saveMovieButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fillUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.movieDetailsViewModel.canShowSaveMovie() {
            self.saveMovieButton.isHidden = false
        }
        else {
            self.saveMovieButton.isHidden = true
        }
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
    func fillUI(){
        SwiftSpinner.show("Setting Up Movie Details baby .....")
        self.movieName.text = self.movieDetailsViewModel.getMovieTitle()
        updateImage()
    }
    
    func updateImage(){
        
        func onImageRetrieved(image:UIImage?){
            DispatchQueue.main.async {
                SwiftSpinner.hide()
                guard let image = image else{
                    return
                }
                self.imageView.image = image
            }
            
        }
        self.movieDetailsViewModel.getPosterImage(completion: onImageRetrieved)
    }
    
    @IBAction func onSaveMovieClicked(sender:UIButton){
    
        var title : String,message : String
        if(self.movieDetailsViewModel.saveMovie()){
            print("saving movie succeeded")
            title = "Success"
            message = "Successfully added Movie to WatchList"
        }
        else{
            title = "Oops!!! Error"
            message = "Unable to add movie"
        }
        
        let alertCOntroller = UIUtilities.createAlert(title: title, message: message)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertCOntroller.addAction(cancelAction)
        self.present(alertCOntroller, animated: true, completion: nil)
    }

}
