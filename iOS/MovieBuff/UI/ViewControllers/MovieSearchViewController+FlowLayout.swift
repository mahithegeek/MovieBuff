//
//  MovieSearchViewController+FlowLayout.swift
//  MovieBuff
//
//  Created by nimma01 on 22/06/18.
//  Copyright © 2018 Mahendra. All rights reserved.
//

import Foundation
import UIKit
extension MovieSearchViewController : UICollectionViewDelegateFlowLayout{
    
   
    
    //MARK collection view flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        //        let availableWidth = view.frame.width - paddingSpace
        //        let widthPerItem = availableWidth / itemsPerRow
        //
        //        return CGSize(width: widthPerItem, height: widthPerItem)
        
        let width = collectionView.frame.width / 3 - 40 / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.left
    }
}
