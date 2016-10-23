//
//  DataSourceTestStateBuilder.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation
@testable import Mojave

struct TestModel: DataSourceModel {
    var name: String
}

struct GenericSection: DataSourceSection {
    var items: [DataSourceModel]
    
    init(items: [DataSourceModel]) {
        self.items = items
    }
}

struct DataSourceTestStateBuilder {
    
    func generateTestState(sectionCount: Int, itemsPerSection: Int) -> DataSourceState {
        var sections = [DataSourceSection]()
        for _ in 0..<sectionCount {
            let items = [DataSourceModel](repeating: TestModel(name: "Andrew"), count: itemsPerSection)
            sections.append(GenericSection(items: items))
        }
        return DataSourceState(sections: sections)
    }
    
}
