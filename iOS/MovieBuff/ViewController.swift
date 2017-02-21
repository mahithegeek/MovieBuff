//
//  ViewController.swift
//  MovieBuff
//
//  Created by Mahendra on 25/01/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import UIKit
import Moya


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        let provider = MoyaProvider<weMakeSitesService>()
        provider.request(.getMoviesForActor(actor: "Robert")) { result in
            switch result {
            case let .success(moyaResponse) :
                print(moyaResponse)
                
            default :
                break
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

