//
//  MojaveTests.swift
//  MojaveTests
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import XCTest
@testable import Mojave

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
        
        var change = DataSourceChangeset.empty
        change.append(insertedSections: [0 : GenericSection(items: []), 1: GenericSection(items: [TestModel(name: "Hello")])])
        dataSource.apply(changeset: change)
        
        let new = dataSource.state
        XCTAssertTrue(new.numberOfSections == 2)
        XCTAssertTrue(new.numberOfItems(in: 1) == 1)
    }
    
}
