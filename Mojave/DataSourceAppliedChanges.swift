//
//  DataSourceAppliedChanges.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation

public struct DataSourceAppliedChanges {
    let updatedIndexPaths: Set<IndexPath>
    let removedIndexPaths: Set<IndexPath>
    let removedSections: IndexSet
    let movedIndexPaths: [IndexPath : IndexPath]
    let insertedSections: IndexSet
    let insertedIndexPaths: Set<IndexPath>
}
