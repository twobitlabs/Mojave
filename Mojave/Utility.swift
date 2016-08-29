//
//  Utility.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/28/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func append(_ rhs: [Key : Value]) {
        for (k, v) in rhs {
            updateValue(v, forKey: k)
        }
    }
}

extension Set {
    mutating func append(_ rhs: Set<Element>) {
        for e in rhs {
            update(with: e)
        }
    }
}

extension IndexSet {
    mutating func append(_ rhs: IndexSet) {
        for e in rhs {
            update(with: e)
        }
    }
}


