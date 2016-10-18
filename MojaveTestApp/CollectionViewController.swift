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

struct TestModel: DataSourceModel {
    let color: UIColor
}

struct Section: DataSourceSection {
    var items = [DataSourceModel]()
}

class CollectionViewController: UICollectionViewController, DataSourceDelegate {

    var dataSource: DataSource
    
    var dataSourceCollectionView: UICollectionView? {
        return collectionView
    }
    
    init() {
        let initialState = DataSourceState(sections: [Section()])
        dataSource = DataSource(initialState: initialState)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        let initialState = DataSourceState(sections: [Section()])
        dataSource = DataSource(initialState: initialState)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var changeset = DataSourceChangeset.empty
        let firstSectionItems = [TestModel(color: .blue),
                                 TestModel(color: .red),
                                 TestModel(color: .green),
                                 TestModel(color: .orange),
                                 TestModel(color: .purple)]
        
        let newSection = Section(items: firstSectionItems)
        changeset.append(insertedSections: [0 : newSection])
        dataSource.apply(changeset: changeset)
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
        
        let item = dataSource.state.item(at: indexPath)
        
        if let item = item as? TestModel {
            cell.contentView.backgroundColor = item.color
        } else {
            fatalError("INVALID CELL")
        }

        return cell
    }
    
    func dataSource(_ dataSource: DataSource, didModify previousState: DataSourceState, with changes: DataSourceAppliedChanges) {}

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
