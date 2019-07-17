//
//  ArticleItemController.swift
//  NYTimesApp
//
//  Created by Nanjunda Swamy on 18/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation
import UIKit
import IGListKit
import NYTimesCore

class ArticleItemController: ListSectionController {
    
    fileprivate var item:Article?
    
    override init() {
        super.init()
        
        inset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right:8)
    }
    
    // Device Size support - TODO
    fileprivate var itemSize: CGSize {
        
        let collectionViewWidth = collectionContext?.containerSize.width ?? 0
        let itemWidth = collectionViewWidth
        let heightRatio: CGFloat = 0.3
        
        return CGSize(width: itemWidth-(inset.left+inset.right), height: itemWidth * heightRatio)
    }
}

extension ArticleItemController {
    
    override func numberOfItems() -> Int {
        return (item != nil) ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return self.itemSize
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell = collectionContext!.dequeueReusableCell(withNibName:"ArticleListCell", bundle: nil, for: self, at: index) as! ArticleListCell
        
        cell.titleLabel?.text = item?.title
        cell.descLabel?.text = item?.abstract

        return cell
    }
    
    override func didUpdate(to object: Any) {
        item = object as? Article
    }
    
    override func didSelectItem(at index: Int) {
        viewController?.performSegue(withIdentifier: "showDetail", sender: item)
    }
}
