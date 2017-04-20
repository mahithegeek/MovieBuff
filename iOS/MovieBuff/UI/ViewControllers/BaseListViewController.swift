//
//  BaseListViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 20/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BaseListViewController: UIViewController,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    @IBOutlet var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Empty data set
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Hey Welcome !!!"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Search your favorite Movies and add them to WatchList :)"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
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
