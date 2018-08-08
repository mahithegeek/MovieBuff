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
        
        launchMoviesTab()
    }
    
    @IBAction func tvButtonClicked (sender :UIButton) {
        let alertController = UIAlertController(title: "Books", message: "Books Coming Soon", preferredStyle:.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController,animated: true, completion: nil);
    }
    
    private func launchMoviesTab(){
        let storyBoard = UIStoryboard(name: "MovieStoryboard", bundle: nil)
        let tabController : UITabBarController = storyBoard.instantiateInitialViewController() as! UITabBarController
        setUpTabController(tabController: tabController)
        tabController.selectedIndex = 0
        self.present(tabController, animated: true, completion: nil)
    }
    
    
    private func setUpTabController(tabController: UITabBarController){
        setUpMovieWatchListVC(tabController: tabController)
        setUpMovieSearchVC(tabController: tabController)
    }
    
    private func setUpMovieWatchListVC (tabController : UITabBarController){
        let destinationController = tabController.viewControllers?[0] as! UINavigationController
        let movieWatchListViewController = destinationController.topViewController as! MovieWatchListViewController
        movieWatchListViewController.watchListViewModel = MovieWatchListViewModel(movies: DataController.sharedInstance.getMovieWatchList())
    }
    
    private func setUpMovieSearchVC (tabController : UITabBarController){
        let movieSearchDestination = tabController.viewControllers?[1] as! UINavigationController
        let movieSearchViewController = movieSearchDestination.topViewController as! MovieSearchViewController
        movieSearchViewController.searchViewModel = MovieSearchViewModel(dataProvider: getMovieDataProvider())
    }
    
    private func getMovieDataProvider()->MovieDataprovider {
        let dataProvider = MovieDataprovider(provider: .iTunesService)
        return dataProvider
    }
    
}
