//
//  DataSourceTestStateBuilder.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation
@testable import Mojave

struct DataSourceTestStateBuilder {
    
    func generateTestState(sectionCount: Int, itemsPerSection: Int) -> DataSourceState {
        var sections = [DataSourceSection]()
        for _ in 0..<sectionCount {
            let items = [DataSourceModel](repeating: TestModel(name: "Andrew"), count: itemsPerSection)
            sections.append(DataSourceSection(items: items))
        }
        return DataSourceState(sections: sections)
    }
    
}
