//
//  CacheTests.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 10/23/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import XCTest
@testable import Mojave

class CacheTests: XCTestCase {
    
    var archiver: Archiver!
    
    override func setUp() {
        super.setUp()
        archiver = Archiver()
        cacheDelete()
    }
    
    override func tearDown() {
        super.tearDown()
        archiver = nil
    }
    
    lazy var testDate: Date = {
        return Date()
    }()
    
    var testURL: URL {
        let _url = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let url = _url.appendingPathComponent("test_path_component")
        return url
    }
    
    func testCaching() {
        let exp = expectation(description: "testCacheRead")
        
        let modelA = Wat(id: 28, path: "cool_path")
        let modelB = Model(id: 1, name: "Andrew", date: testDate, fav: true, wat: modelA)
        
        archiver.archive(modelB, to: testURL, on: .main) { result in
            switch result {
            case .success(let url):
                XCTAssertEqual(self.testURL, url)
                
                let model = try! self.archiver.sync_unarchive(self.testURL) as Model
                
                XCTAssertEqual(model.id, 1)
                XCTAssertEqual(model.name, "Andrew")
                XCTAssertEqual(model.fav, true)
                XCTAssertEqual(model.date, self.testDate)
                XCTAssertEqual(model.id, 1)
                XCTAssertEqual(model.wat.id, 28)
                XCTAssertEqual(model.wat.path, "cool_path")
                
                exp.fulfill()
            case .error(_):
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func cacheDelete() {
        archiver.removeArchive(at: testURL, with: nil)
    }
}

struct Wat: Cacheable {
    let id: Int
    let path: String
    
    init(id: Int, path: String) {
        self.id = id
        self.path = path
    }
    
    func encode(with coder: Coder) {
        coder.encode(id, for: "id")
        coder.encode(path, for: "path")
    }
    
    init?(with coder: Coder) {
        do {
            id = try coder.decode(for: "id")
            path = try coder.decode(for: "path")
        } catch { return nil }
    }
}

struct Model: Cacheable {
    let id: Int
    let name: String
    let date : Date
    let fav: Bool
    let wat: Wat
    
    init(id: Int, name: String, date: Date, fav: Bool, wat: Wat) {
        self.id = id
        self.name = name
        self.date = date
        self.fav = fav
        self.wat = wat
    }
    
    func encode(with coder: Coder) {
        coder.encode(id, for: "id")
        coder.encode(name, for: "name")
        coder.encode(date, for: "date")
        coder.encode(fav, for: "fav")
        coder.encode(wat, for: "wat")
        
        let nums = [1,2,3]
        coder.encode(nums, for: "nums")
    }
    
    init?(with coder: Coder) {
        do {
            id = try coder.decode(for: "id")
            name = try coder.decode(for: "name")
            date = try coder.decode(for: "date")
            fav = try coder.decode(for: "fav")
            wat = try coder.decode(for: "wat")
        } catch { return nil }
    }
}
