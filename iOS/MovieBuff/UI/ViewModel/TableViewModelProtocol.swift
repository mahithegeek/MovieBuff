//
//  File.swift
//  MovieBuff
//
//  Created by Mahendra on 10/04/17.
//  Copyright © 2017 Mahendra. All rights reserved.
//

import Foundation
protocol tableViewModel {
    func getNumberOfRows()->Int
    func getNumberOfSections()->Int
    func getModelForCell(indexPath:IndexPath)->Any
    func selectedRow(indexPath:IndexPath)
}
