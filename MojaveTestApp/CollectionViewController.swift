//
//  CollectionViewController.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/28/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import UIKit
import Mojave

private let reuseIdentifier = "Cell"

struct TestModel: DataSourceModel {}

class CollectionViewController: UICollectionViewController, DataSourceDelegate {

    var dataSource: DataSource
    
    var dataSourceCollectionView: UICollectionView? {
        return collectionView
    }
    
    init() {
        let initialState = DataSourceState(sections: [DataSourceSection(items: [])])
        dataSource = DataSource(initialState: initialState)
        
        
        dataSource.state.sections[0].items[0] = TestModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        let initialState = DataSourceState(sections: [DataSourceSection(items: [])])
        dataSource = DataSource(initialState: initialState)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.state.numberOfSections
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.state.numberOfItems(in: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    func dataSource(_ dataSource: DataSource, didModify previousState: DataSourceState, with changes: DataSourceAppliedChanges) {}

}
