//
//  FavoriteListController.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let presenter: FavoriteListPresenterType = FavoriteListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.view = self
        self.collectionView.dataSource = self.presenter
        self.presenter.fetchData()
    }
    
}

extension FavoriteListViewController: FavoriteListViewType {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
