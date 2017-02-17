//
//  TimeInterval.swift
//  Chronus
//
//  Created by Shao Tianchi on 2017/1/17.
//  Copyright © 2017年 Shao Tianchi. All rights reserved.
//

import Cocoa
import RealmSwift

class CRNTimeInterval: Object {
    dynamic var begin: Date?
    dynamic var end: Date?
    
    var interval: TimeInterval {
        guard let begin = begin,
              let end = end else {
                return 0
        }
        
        return end.timeIntervalSince(begin)
    }
    
    override static func ignoredProperties() -> [String] {
        return ["interval"]
    }
}
