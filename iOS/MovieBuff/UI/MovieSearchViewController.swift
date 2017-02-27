//
//  MovieSearchViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 23/02/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
enum SearchSection : Int {
    case Count,Actors,Titles
    
    static var count = {
        return SearchSection.Count.rawValue
    }
    
    static let sectionTitles = [
        Actors : "Actors",
        Titles : "Titles"
    ]
    
    func sectionTitle()->String {
        if let sectionTitle = SearchSection.sectionTitles[self] {
            return sectionTitle
        } else{
            return ""
        }
    }
    
}

class MovieSearchViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    
    var searchViewModel : SearchViewModel!

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.numberOfRowsForModel(sectionNumber: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return cellForIndex(indexPath: indexPath)
    }
    
    private func cellForIndex (indexPath:IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchController", for: indexPath)
        let filmObject : Actor = searchViewModel.modelForCell(section: indexPath.section, row: indexPath.row)
        cell.textLabel?.text = filmObject.title
        return cell
    }
    

}
