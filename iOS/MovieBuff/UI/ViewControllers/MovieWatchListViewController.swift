//
//  MovieWatchListViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 10/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit


class MovieWatchListViewController: BaseListViewController,UITableViewDelegate,UITableViewDataSource {
    
    //@IBOutlet weak var tableView : UITableView!
    //var movieWatchList : [Movie] = []
    var watchListViewModel : MovieWatchListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.9, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.watchListViewModel.refreshMovieWatchList()
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 0
        return self.watchListViewModel.getNumberOfRows();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        //return self.watchListViewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchList", for: indexPath)

        let movie = self.watchListViewModel.getModelForCell(indexPath: indexPath) as! MovieCoreDataObject
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
        
        let index = self.tableView.indexPathForSelectedRow!
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
