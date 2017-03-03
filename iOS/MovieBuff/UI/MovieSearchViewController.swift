//
//  MovieSearchViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 23/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
class MovieSearchViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet var tableView : UITableView!
    
    var searchViewModel : SearchViewModel!
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
        guard let filmObject : Actor = searchViewModel.modelForCell(section: indexPath.section, row: indexPath.row) else { return cell}
        cell.textLabel?.text = filmObject.title
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
        self.showLoadingIndicator()
        //getSearchResultsForString(searchString: searchBar.text!)
    }
    
    private func showLoadingIndicator(){
        self.loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.loadingIndicator?.center = self.tableView.center
        self.tableView.addSubview(self.loadingIndicator!)
        self.loadingIndicator!.startAnimating()
        
    }
    
    private func stopLoadingIndicator(){
        self.loadingIndicator!.stopAnimating()
    }
    
     private func getSearchResultsForString(searchString : String){
        let dataProvider = MovieDataprovider(provider: providerType.weMakeSites)
        func searchResultsCallback (dataObjects : [[BaseFilmModel]]??,error:NSError?){
            guard dataObjects != nil else {print(error ?? "test")
                let alert = UIAlertController(title: "Error!!!", message: error?.localizedDescription, preferredStyle: .alert)
                present(alert, animated: true, completion: nil)
                return
            }
            
            self.searchViewModel.updateModel(filmModel: dataObjects!!)
            self.stopLoadingIndicator()
            self.tableView.reloadData()
        }
        dataProvider.getSearchResults(searchString: searchString, completion: searchResultsCallback)
    }

}
