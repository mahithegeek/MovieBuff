//
//  MovieSearchViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 23/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
import SwiftSpinner
class MovieSearchViewController: BaseListViewController,UITableViewDataSource,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var collectionView : UICollectionView!
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10, bottom: 10.0, right: 10)
    fileprivate let itemsPerRow: CGFloat = 3
    
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
    
    //Mark - Collection View methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.numberOfRowsForModel(sectionNumber: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchController", for: indexPath) as! ThumbnailCell
        
        func completionHandler(image:UIImage?){
            guard let image = image
                else{
                    return 
            }
            DispatchQueue.main.async{
                cell.thumbNail?.image = image
            }
            
        }
        
        searchViewModel.imageForCell(section: indexPath.section, row: indexPath.row, completion: completionHandler)
        
        return cell
    }
    
    //MARK collection view flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//
//        return CGSize(width: widthPerItem, height: widthPerItem)
        
        let width = collectionView.frame.width / 3 - 40 / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        searchViewModel.willDisplayCell(section: indexPath.section, row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchViewModel.didEndDisplay(section: indexPath.section, row: indexPath.row)
    }
    
    //Mark - Search Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getSearchResultsForString(searchString:)), object: searchText)
        //self.perform(#selector(self.getSearchResultsForString(searchString:)),with:searchText,afterDelay:0.5)
        //Do nothing right now
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        SwiftSpinner.show("Fetching your Search....")
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
            
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
            
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
