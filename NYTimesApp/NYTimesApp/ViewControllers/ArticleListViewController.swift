//
//  ArticleListViewController.swift
//  NYTimesApp
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import Foundation
import UIKit
import IGListKit
import RealmSwift
import NYTimesCore

class ArticleListViewController: UIViewController {

    let collectionView: UICollectionView = {
        
        let flowLayout = ListCollectionViewLayout(stickyHeaders: false, topContentInset:0, stretchToEdge: true)
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .darkGray
        refreshControl.addTarget(self, action: #selector(ArticleListViewController.didPullToRefresh), for: .valueChanged)
        view.addSubview(refreshControl)
        
        view.refreshControl = refreshControl
        
        return view
    }()


    let spinnerObject = "spinner"
    var isLoading = false
    var data: Array<Article> = []
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "NY Times"
        
        view.addSubview(collectionView)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self // Load More
        
        refreshFeed()
    }
    
    @objc func didPullToRefresh() {

    }

}

extension ArticleListViewController {
    
    func refreshFeed(ignoreCache:Bool = false) {
        
        DataManager.sharedInstance.getViewedArticles(period: "1", params: nil) { (status) in

            if status.isSuccess{
                let items:Array<Article> = Array(status.value!)
                self.data.append(contentsOf: items)
            }
            
            self.isLoading = false
            
            self.adapter.performUpdates(animated: true, completion: nil)
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

extension ArticleListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail"{
            
            if let anItem = sender as? Article {
                let viewController = segue.destination as! ArticleDetailViewController
                viewController.item = anItem
            }
        }
    }
}

extension ArticleListViewController: ListAdapterDataSource, ListSingleSectionControllerDelegate {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        var objects = data as Array<Any>
        
        if(isLoading){
            objects.append(spinnerObject)
        }
        
        return objects as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if let object = object as? String , object == spinnerObject{
            return LoadMoreController()
        }
        
        let controller =  ArticleItemController() as ListSectionController
        
        return controller
    }
    
    // Protocol Stubs
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) { }
}


extension ArticleListViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !isLoading && distance < 200 {
            
           //Load More
        }
    }
}
