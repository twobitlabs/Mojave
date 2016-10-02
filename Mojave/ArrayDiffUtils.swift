//
//  ArrayDiffUtils.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 10/2/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation

extension NSRange {
    var range: Range<Int> {
        return location..<location+length
    }
    
    init(range: Range<Int>) {
        location = range.lowerBound
        length = range.upperBound - range.lowerBound
    }
}

// MARK: NSIndexSet -> [NSIndexPath] conversion

extension NSIndexSet {
    /**
     Returns an array of NSIndexPaths that correspond to these indexes in the given section.
     
     When reporting changes to table/collection view, you can improve performance by sorting
     deletes in descending order and inserts in ascending order.
     */
    func indexPathsInSection(section: Int, ascending: Bool = true) -> [NSIndexPath] {
        var result: [NSIndexPath] = []
        result.reserveCapacity(count)
        enumerate(options: ascending ? [] : .reverse) { index, _ in
            result.append(NSIndexPath(indexes: [section, index], length: 2))
        }
        return result
    }
}

// MARK: NSIndexSet support

extension Array {

    subscript (indexes: NSIndexSet) -> [Element] {
        var result: [Element] = []
        result.reserveCapacity(indexes.count)
        indexes.enumerateRanges(options: []) { nsRange, _ in
            result += self[nsRange.range]
        }
        return result
    }
    
    mutating func removeAtIndexes(indexSet: NSIndexSet) {
        indexSet.enumerateRanges(options: [.reverse]) { nsRange, _ in
            self.removeSubrange(nsRange.range)
        }
    }
    
    mutating func insertElements(newElements: [Element], atIndexes indexes: NSIndexSet) {
        assert(indexes.count == newElements.count)
        var i = 0
        indexes.enumerateRanges(options: []) { range, _ in
            self.insert(contentsOf: newElements[i..<i+range.length], at: range.location)
            i += range.length
        }
    }
}
