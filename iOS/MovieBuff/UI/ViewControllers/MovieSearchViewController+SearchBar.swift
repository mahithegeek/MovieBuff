//
//  MovieSearchViewController+SearchBar.swift
//  MovieBuff
//
//  Created by nimma01 on 22/06/18.
//  Copyright © 2018 Mahendra. All rights reserved.
//

import Foundation
import UIKit
import SwiftSpinner
extension MovieSearchViewController : UISearchBarDelegate {
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
            
            reloadView()
            
        }
        self.searchViewModel.searchMovies(searchString: searchString, completion: searchResultsCallback)
    }
}
