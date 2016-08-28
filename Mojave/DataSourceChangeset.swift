//
//  DataSourceChangeset.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation

public struct DataSourceChangeset {
    public typealias UpdatedItems = [IndexPath : DataSourceModel]
    public typealias RemovedItems = Set<IndexPath>
    public typealias RemovedSections = IndexSet
    public typealias MovedItems = [IndexPath: IndexPath]
    public typealias InsertedSections = IndexSet
    public typealias InsertedItems = [IndexPath : DataSourceModel]
    
    private(set) public var updatedItems: UpdatedItems
    private(set) public var removedItems: RemovedItems
    private(set) public var removedSections: RemovedSections
    private(set) public var movedItems: MovedItems
    private(set) public var insertedSections: InsertedSections
    private(set) public var insertedItems: InsertedItems
    
    public func with(updatedItems: UpdatedItems) -> DataSourceChangeset {
        var c = self; c.updatedItems = updatedItems; return c
    }
    
    public func with(removedItems: RemovedItems) -> DataSourceChangeset {
        var c = self; c.removedItems = removedItems; return c
    }
    
    public func with(removedSections: RemovedSections) -> DataSourceChangeset {
        var c = self; c.removedSections = removedSections; return c
    }
    
    public func with(movedItems: MovedItems) -> DataSourceChangeset {
        var c = self; c.movedItems = movedItems; return c
    }
    
    public func with(insertedSections: InsertedSections) -> DataSourceChangeset {
        var c = self; c.insertedSections = insertedSections; return c
    }
    
    public func with(insertedItems: InsertedItems) -> DataSourceChangeset {
        var c = self; c.insertedItems = insertedItems; return c
    }
    
    public init(updatedItems: UpdatedItems,
         removedItems: RemovedItems,
         removedSections: RemovedSections,
         movedItems: MovedItems,
         insertedSections: InsertedSections,
         insertedItems: InsertedItems) {
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
        return DataSourceChangeset(updatedItems: UpdatedItems(),
                                   removedItems: RemovedItems(),
                                   removedSections: RemovedSections(),
                                   movedItems: MovedItems(),
                                   insertedSections: InsertedSections(),
                                   insertedItems: InsertedItems())
    }
}
