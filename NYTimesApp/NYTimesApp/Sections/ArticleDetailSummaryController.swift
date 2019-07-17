//
//  ArticleDetailSummaryController.swift
//  NYTimesApp
//
//  Created by Nanjunda Swamy on 18/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation
import UIKit
import IGListKit
import NYTimesCore

func ArticleDetailSummaryController() -> ListSingleSectionController {
    
    let configureBlock = { (item: Any, cell: UICollectionViewCell) in
        
        guard let cell = cell as? ArticleDetailSummaryCell, let article = item as? Article  else { return }
        cell.titleLabel?.text = article.title
        cell.abstractLabel?.text = article.abstract        
    }
    
    let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
        guard let context = context else { return .zero }
        return CGSize(width: context.containerSize.width, height: 450)
    }
    
    return ListSingleSectionController(nibName: "ArticleDetailSummaryCell", bundle: nil, configureBlock: configureBlock, sizeBlock: sizeBlock)
}
