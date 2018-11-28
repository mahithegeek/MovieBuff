//
//  MovieWatchListViewModel.swift
//  MovieBuff
//
//  Created by Mahendra on 10/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
class MovieWatchListViewModel : tableViewModel{
    private var movies : [Movie]
    
    init(movies:[Movie]){
        self.movies = movies
    }
    
    func refreshMovieWatchList(){
        self.movies = DataController.sharedInstance.getMovieWatchList()
    }
    
    func getNumberOfSections() -> Int {
        if(self.movies.count > 0){
            return 1
        }
        return 0
    }
    
    func getNumberOfRows() -> Int {
        return self.movies.count
    }
    
    func getModelForCell(indexPath: IndexPath) -> Any {
        return self.movies[indexPath.row]
    }
    
    func selectedRow(indexPath: IndexPath) {
        //do nothing
        
    }
}
