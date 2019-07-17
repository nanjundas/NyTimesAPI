//
//  ArticleDetailSummaryCell.swift
//  NYTimesApp
//
//  Created by Nanjunda Swamy on 18/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation
import UIKit

class ArticleDetailSummaryCell: UICollectionViewCell {
    
    @IBOutlet public var titleLabel: UILabel?
    @IBOutlet public var backdropImageView: UIImageView?
    @IBOutlet public var abstractLabel: UILabel?
    
    //TODO: Add few more fields
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
