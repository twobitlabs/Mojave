//
//  DataSourceChangeset.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation

public struct DataSourceChangeset {
    private(set) public var updatedItems: [IndexPath : DataSourceModel]
    private(set) public var removedItems: Set<IndexPath>
    private(set) public var removedSections: IndexSet
    private(set) public var movedItems: [IndexPath: IndexPath]
    private(set) public var insertedSections: [Int : DataSourceSection]
    private(set) public var insertedItems: [IndexPath : DataSourceModel]
    
    public static func with(updatedItems: [IndexPath : DataSourceModel]) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(updatedItems: updatedItems)
        return c
    }
    
    public static func with(removedItems: Set<IndexPath>) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(removedItems: removedItems)
        return c
    }
    
    public static func with(removedSections: IndexSet) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(removedSections: removedSections)
        return c
    }
    
    public static func with(movedItems: [IndexPath: IndexPath]) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(movedItems: movedItems)
        return c
    }
    
    public static func with(insertedSections: [Int : DataSourceSection]) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(insertedSections: insertedSections)
        return c
    }
    
    public static func with(insertedItems: [IndexPath : DataSourceModel]) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(insertedItems: insertedItems)
        return c
    }
    
    public mutating func append(updatedItems: [IndexPath : DataSourceModel]) {
        self.updatedItems.append(updatedItems)
    }
    
    public mutating func append(removedItems: Set<IndexPath>) {
        self.removedItems.append(removedItems)
    }
    
    public mutating func append(removedSections: IndexSet) {
        self.removedSections.append(removedSections)
    }
    
    public mutating func append(movedItems: [IndexPath: IndexPath]) {
        self.movedItems.append(movedItems)
    }
    
    public mutating func append(insertedSections: [Int : DataSourceSection]) {
        self.insertedSections.append(insertedSections)
    }
    
    public mutating func append(insertedItems: [IndexPath : DataSourceModel]) {
        self.insertedItems.append(insertedItems)
    }
    
    public init(updatedItems: [IndexPath : DataSourceModel],
         removedItems: Set<IndexPath>,
         removedSections: IndexSet,
         movedItems: [IndexPath: IndexPath],
         insertedSections: [Int : DataSourceSection],
         insertedItems: [IndexPath : DataSourceModel]) {
        self.updatedItems = updatedItems
        self.removedItems = removedItems
        self.removedSections = removedSections
        self.movedItems = movedItems
        self.insertedSections = insertedSections
        self.insertedItems = insertedItems
    }
}

extension DataSourceChangeset {
    public static var empty: DataSourceChangeset {
        return DataSourceChangeset(updatedItems: [IndexPath : DataSourceModel](),
                                   removedItems: Set<IndexPath>(),
                                   removedSections: IndexSet(),
                                   movedItems: [IndexPath: IndexPath](),
                                   insertedSections: [Int : DataSourceSection](),
                                   insertedItems: [IndexPath : DataSourceModel]())
    }
}
