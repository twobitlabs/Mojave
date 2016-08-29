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
    
    public static func with(updatedItems: UpdatedItems) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(updatedItems: updatedItems)
        return c
    }
    
    public static func with(removedItems: RemovedItems) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(removedItems: removedItems)
        return c
    }
    
    public static func with(removedSections: RemovedSections) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(removedSections: removedSections)
        return c
    }
    
    public static func with(movedItems: MovedItems) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(movedItems: movedItems)
        return c
    }
    
    public static func with(insertedSections: InsertedSections) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(insertedSections: insertedSections)
        return c
    }
    
    public static func with(insertedItems: InsertedItems) -> DataSourceChangeset {
        var c = DataSourceChangeset.empty
        c.append(insertedItems: insertedItems)
        return c
    }
    
    public mutating func append(updatedItems: UpdatedItems) {
        self.updatedItems.append(updatedItems)
    }
    
    public mutating func append(removedItems: RemovedItems) {
        self.removedItems.append(removedItems)
    }
    
    public mutating func append(removedSections: RemovedSections) {
        self.removedSections.append(removedSections)
    }
    
    public mutating func append(movedItems: MovedItems) {
        self.movedItems.append(movedItems)
    }
    
    public mutating func append(insertedSections: InsertedSections) {
        self.insertedSections.append(insertedSections)
    }
    
    public mutating func append(insertedItems: InsertedItems) {
        self.insertedItems.append(insertedItems)
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
