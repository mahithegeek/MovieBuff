//
//  MovieWatchListViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 10/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit

class MovieWatchListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var watchList : UITableView!
    //var movieWatchList : [Movie] = []
    var watchListViewModel : MovieWatchListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.watchListViewModel.refreshMovieWatchList()
        self.watchList.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.watchListViewModel.getNumberOfRows();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.watchListViewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchList", for: indexPath)

        let movie = self.watchListViewModel.getModelForCell(indexPath: indexPath) as! Movie
        cell.textLabel?.text = movie.getTitleString()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.watchListViewModel.getModelForCell(indexPath: indexPath)
        let movieDetailsVC: MovieDetailsViewController = UIStoryboard(name: "MovieStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movie as! Movie)
        movieDetailsVC.movieDetailsViewModel = movieDetailsViewModel
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = self.watchList.indexPathForSelectedRow!
        let movie = self.watchListViewModel.getModelForCell(indexPath: index)
        let destination: MovieDetailsViewController =  segue.destination as! MovieDetailsViewController
        destination.movieDetailsViewModel = MovieDetailsViewModel(movie: movie as! Movie)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
