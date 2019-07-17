//
//  ArticleDetailViewController.swift
//  NYTimesApp
//
//  Created by Nanjunda Swamy on 18/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation
import UIKit
import IGListKit
import RealmSwift
import NYTimesCore


class ArticleDetailViewController: UICollectionViewController {
    
    var item:Article? {
        didSet {
            refreshDetails()
        }
    }
    
    var sectionData:Array<Any> = []
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
}

extension ArticleDetailViewController {
    
    func refreshDetails() {
        
        title = " "

        self.sectionData.removeAll()

        self.sectionData.append(item as Any)
    }
}

extension ArticleDetailViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return sectionData as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if((object as? Article) != nil) {
            return ArticleDetailSummaryController()
        }

        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
