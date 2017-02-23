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
        
        //let alertController = UIAlertController(title: "Movies", message: "Movies Coming Soon", preferredStyle:.alert)
        //self.present(alertController,animated: true, completion: nil);
        
        /*let storyBoard = UIStoryboard(name: "MovieStoryboard", bundle: nil)
        let viewController : UIViewController = storyBoard.instantiateInitialViewController()! as UIViewController
        //viewController
        self.present(viewController, animated: true, completion: nil)*/
        makeMoyaCall()
    }
    
    @IBAction func tvButtonClicked (sender :UIButton) {
        makeMoyaCall()
        /*
        let alertController = UIAlertController(title: "TV", message: "Movies Coming Soon", preferredStyle:.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController,animated: true, completion: nil);*/
    }
    
    private func makeMoyaCall (){
        let dataProvider = MovieDataprovider(movieService: weMakeSitesService())
        
        func searchResultsCallback (dataObjects : [[BaseFilmModel]],error:NSError?){
            print(dataObjects)
            showResults(data: dataObjects)
        }
        dataProvider.getSearchResults(searchString: "Tom Cruise", completion: searchResultsCallback)
    }
    
    private func showResults(data:[[BaseFilmModel]]) {
        let storyBoard = UIStoryboard(name: "MovieStoryboard", bundle: nil)
        let viewController : MovieSearchViewController = storyBoard.instantiateInitialViewController()! as! MovieSearchViewController
        viewController.searchViewModel = SearchViewModel(filmModel: data)
        
        self.present(viewController, animated: true, completion: nil)
    }
}
