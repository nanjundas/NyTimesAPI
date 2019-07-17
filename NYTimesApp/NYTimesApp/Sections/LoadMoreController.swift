//
//  LoadMoreController.swift
//  NYTimesApp
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation
import UIKit
import IGListKit

func LoadMoreController() -> ListSingleSectionController {
    
    let configureBlock = { (item: Any, cell: UICollectionViewCell) in
        guard let cell = cell as? LoadMoreCell else { return }
        cell.activityIndicator.startAnimating()
    }
    
    let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
        guard let context = context else { return .zero }
        return CGSize(width: context.containerSize.width, height: 100)
    }
    
    return ListSingleSectionController(cellClass: LoadMoreCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
}

final class LoadMoreCell: UICollectionViewCell {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        self.contentView.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
