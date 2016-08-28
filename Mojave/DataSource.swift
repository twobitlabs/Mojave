//
//  DataSource.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation
import UIKit

public protocol DataSourceDelegate: class {
    var dataSourceCollectionView: UICollectionView { get }
    func dataSource(_ dataSource: DataSource, didModify previousState: DataSourceState, with changes: DataSourceAppliedChanges)
}

public struct DataSource {
    public weak var delegate: DataSourceDelegate?
    private(set) public var state: DataSourceState
    
    public init(initialState: DataSourceState = .defaultState, delegate: DataSourceDelegate? = nil) {
        self.delegate = delegate
        self.state = initialState
    }
    
    public mutating func apply(changeset: DataSourceChangeset) {
        let previousState = state
        let changes = DataSourceChangesetModification(changeset: changeset).change(from: state)
        state = changes.state
        
        update(with: changes, from: previousState)
    }
    
    private func update(with change: DataSourceChange, from previous: DataSourceState) {
        guard let delegate = delegate else { return }
        let appliedChanges = change.appliedChanges
        delegate.dataSourceCollectionView.performBatchUpdates({
            delegate.dataSourceCollectionView.deleteSections(appliedChanges.removedSections)
            delegate.dataSourceCollectionView.insertSections(appliedChanges.insertedSections)
            delegate.dataSourceCollectionView.deleteItems(at: Array(appliedChanges.removedIndexPaths))
            delegate.dataSourceCollectionView.reloadItems(at: Array(appliedChanges.updatedIndexPaths))
            delegate.dataSourceCollectionView.insertItems(at: Array(appliedChanges.insertedIndexPaths))
        }) { _ in
            delegate.dataSource(self, didModify: previous, with: appliedChanges)
        }
    }
}
