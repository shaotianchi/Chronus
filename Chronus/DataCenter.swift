//
//  DataCenter.swift
//  Chronus
//
//  Created by Shao Tianchi on 2017/1/17.
//  Copyright © 2017年 Shao Tianchi. All rights reserved.
//

import Cocoa
import RealmSwift

class DataCenter {
    static let instance: DataCenter = DataCenter()
    
    var realm: Realm!
    
    func setup() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                // do something
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        realm = try! Realm()
    }
    
    func add(object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }
}
