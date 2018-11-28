//
//  MovieSearchViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 23/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
import SwiftSpinner
class MovieSearchViewController: UIViewController, UICollectionViewDataSource,MovieSearchViewModelView {
    
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var collectionView : UICollectionView!
    
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 10.0)
    let itemsPerRow: CGFloat = 2
    
    var searchViewModel : MovieSearchViewModel!
    var loadingIndicator : UIActivityIndicatorView?

     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.tableView.reloadData()
        self.collectionView.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.9, alpha: 1.0)
        searchViewModel.delegate = self
        
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                
                //cell.thumbNail?.layer.masksToBounds = true
                //cell.thumbNail?.layer.cornerRadius = 6
                cell.contentView.layer.cornerRadius = 2.0
                cell.contentView.layer.borderWidth = 1.0
                cell.contentView.layer.borderColor = UIColor.clear.cgColor
                cell.contentView.layer.masksToBounds = true
                print("width \(image.size.width) and height is  \(image.size.height)")
                cell.thumbNail?.image = image//self.resizeImage(image: image)
            }
            
        }
        
        searchViewModel.imageForCell(section: indexPath.section, row: indexPath.row, completion: completionHandler)
        
        return cell
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        searchViewModel.willDisplayCell(section: indexPath.section, row: indexPath.row)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        searchViewModel.didEndDisplay(section: indexPath.section, row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //searchViewModel.didEndDisplay(section: indexPath.section, row: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.searchBar.resignFirstResponder()
        let destination: MovieDetailsViewController =  segue.destination as! MovieDetailsViewController
        let index : [IndexPath]  = self.collectionView.indexPathsForSelectedItems!
        let row = index[0];
        destination.movieDetailsViewModel = MovieDetailsViewModel(movie: self.searchViewModel.getSelectedRowObject(row: row.row)!)
        
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}
