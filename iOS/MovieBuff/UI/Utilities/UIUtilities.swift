//
//  UIUtilities.swift
//  MovieBuff
//
//  Created by Mahendra on 07/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
import UIKit

class UIUtilities{
    
    
    class func createAlert(title:String,message:String)->UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        return alert
    }
}
