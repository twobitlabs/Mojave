//
//  DataSourceSection.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation

public struct DataSourceSection: DataSourceSectionType {
    public var items = [DataSourceModel]()
}

public protocol DataSourceSectionType {
    var items: [DataSourceModel] { get set }
}
