//
//  HomeViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 25/01/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
import Moya

class HomeViewController: UIViewController {
    
    @IBOutlet weak var moviesButton : UIButton!
    @IBOutlet weak var tvButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func moviesButtonClicked (sender:UIButton){
        
        let storyBoard = UIStoryboard(name: "MovieStoryboard", bundle: nil)
        let tabController : UITabBarController = storyBoard.instantiateInitialViewController() as! UITabBarController
        let destinationController = tabController.viewControllers?[1] as! UINavigationController
        let movieSearchViewController = destinationController.topViewController as! MovieSearchViewController
        movieSearchViewController.searchViewModel = MovieSearchViewModel(movies: [Movie]())
        tabController.selectedIndex = 1
        self.present(tabController, animated: true, completion: nil)
    }
    
    @IBAction func tvButtonClicked (sender :UIButton) {
        //makeMoyaCall()
        
        let alertController = UIAlertController(title: "TV", message: "TV Coming Soon", preferredStyle:.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController,animated: true, completion: nil);
    }
    
   
    private func launchMovieSearch(destinationController:UINavigationController){
        
        let storyBoard = UIStoryboard(name: "MovieStoryboard", bundle: nil)
        let tabController : UITabBarController = storyBoard.instantiateInitialViewController() as! UITabBarController
        let destinationController = tabController.viewControllers?[1] as! UINavigationController
        let movieSearchViewController = destinationController.topViewController as! MovieSearchViewController
        movieSearchViewController.searchViewModel = MovieSearchViewModel(movies: [Movie]())
        tabController.selectedIndex = 1
        self.present(tabController, animated: true, completion: nil)
    }
    
    private func launchMovieWatchList(){
        
    }
    
}
