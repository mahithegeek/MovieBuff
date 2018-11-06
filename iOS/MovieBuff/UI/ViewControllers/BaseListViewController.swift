//
//  BaseListViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 20/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class BaseListViewController: UIViewController,EmptyDataSetSource,EmptyDataSetDelegate {
    @IBOutlet var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
//        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Empty data set
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Hey Welcome !!!"
        let attrs = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)]
        return NSAttributedString(string: str, attributes: convertToOptionalNSAttributedStringKeyDictionary(attrs))
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Search your favorite Movies and add them to WatchList :)"
        let attrs = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)]
        return NSAttributedString(string: str, attributes: convertToOptionalNSAttributedStringKeyDictionary(attrs))
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
