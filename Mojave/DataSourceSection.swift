//
//  DataSourceSection.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation

public protocol DataSourceSection {
    var items: [DataSourceModel] { get set }
}
