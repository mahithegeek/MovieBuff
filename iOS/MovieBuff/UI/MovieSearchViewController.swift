//
//  MovieSearchViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 23/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
import SwiftSpinner
class MovieSearchViewController: BaseListViewController,UITableViewDataSource,UISearchBarDelegate {
    
    
    @IBOutlet var searchBar : UISearchBar!
    
    var searchViewModel : MovieSearchViewModel!
    var loadingIndicator : UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.tableView.reloadData()
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchViewModel.sectionTitle(sectionNumber: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.numberOfRowsForModel(sectionNumber: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return cellForIndex(indexPath: indexPath)
    }
    
    private func cellForIndex (indexPath:IndexPath)->UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchController", for: indexPath)
        guard let movie : Movie = searchViewModel.modelForCell(section: indexPath.section, row: indexPath.row) else { return cell}
        cell.textLabel?.text = movie.getTitleString()
        return cell
    }
    
    
    //Mark - Search Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getSearchResultsForString(searchString:)), object: searchText)
        //self.perform(#selector(self.getSearchResultsForString(searchString:)),with:searchText,afterDelay:0.5)
        //Do nothing right now
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        SwiftSpinner.show("Fetching your fucking Search....")
        searchMovies(searchString: searchBar.text!)
    }
    
    private func searchMovies(searchString:String){
        func searchResultsCallback(movies : [Movie]?,error:NSError?) {
            SwiftSpinner.hide()
            guard let movies = movies else {
                print(error ?? "Something wrong while fetching moves")
                let alert = UIAlertController(title: "Error!!!", message: error?.localizedDescription, preferredStyle: .alert)
                present(alert, animated: true, completion: nil)
                return
            }
            
            self.searchViewModel.updateModel(movies: movies)
            
            self.tableView.reloadData()
        }
        self.searchViewModel.searchMovies(searchString: searchString, completion: searchResultsCallback)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.searchBar.resignFirstResponder()
        let destination: MovieDetailsViewController =  segue.destination as! MovieDetailsViewController
        let index = self.tableView.indexPathForSelectedRow!
        destination.movieDetailsViewModel = MovieDetailsViewModel(movie: self.searchViewModel.getSelectedRowObject(row: index.row))
        
    }

}
