//
//  MojaveTests.swift
//  MojaveTests
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import XCTest
@testable import Mojave

struct TestModel: DataSourceModel {
    var name: String
}

class MojaveTests: XCTestCase, DataSourceDelegate {
    
    var dataSource: DataSource!
    var testModel: TestModel!
    
    var dataSourceCollectionView: UICollectionView? {
        return nil
    }
    
    override func setUp() {
        super.setUp()
        testModel = TestModel(name: "Andrew")
        dataSource = DataSource()
    }
    
    override func tearDown() {
        testModel = nil
        dataSource = nil
        super.tearDown()
    }
    
    func testInsertion() {
        let existing = dataSource.state
        XCTAssertTrue(existing.numberOfSections == 0)
        
        let sectionsToInsert = IndexSet(integer: 0)
        let itemsToInsert = [IndexPath(item: 0, section: 0) : testModel!]
        var changeset = DataSourceChangeset.empty.with(insertedSections: sectionsToInsert)
        changeset = changeset.with(insertedItems: itemsToInsert)
        dataSource.apply(changeset: changeset)
        
        let new = dataSource.state
        XCTAssertTrue(new.numberOfSections == 1)
        XCTAssertTrue(new.numberOfItems(in: 0) == 1)
    }
    
}
