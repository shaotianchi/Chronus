//
//  App.swift
//  Chronus
//
//  Created by Shao Tianchi on 2017/1/16.
//  Copyright © 2017年 Shao Tianchi. All rights reserved.
//

import Cocoa
import RealmSwift

class App: Object {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var path: String = ""
    let timeIntervals = List<CRNTimeInterval>()
    
    var currentInterval: CRNTimeInterval = CRNTimeInterval()
    
    var total: TimeInterval {
        return timeIntervals.reduce(0, { (r, t) -> TimeInterval in
            return r + t.interval
        })
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["currentInterval", "total"]
    }
    
    class func setup(info: [String : Any]) -> App? {
        guard let appName = info["NSApplicationName"] as? String,
            let appPath = info["NSApplicationPath"] as? String,
            let appID = info["NSApplicationBundleIdentifier"] as? String else {
                return nil
        }
        let app = App()
        app.id = appID
        app.name = appName
        app.path = appPath
        return app
    }
    
    class func setup(runningApplication: NSRunningApplication) -> App? {
        guard let appName = runningApplication.localizedName,
            let appPath = runningApplication.executableURL?.absoluteString,
            let appID = runningApplication.bundleIdentifier else {
                return nil
        }
        
        if let app = CCTV.instance.apps.filter({ (app) -> Bool in
            app.id == appID
        }).first {
            return app
        }
        
        if let app = DataCenter.instance.realm.objects(App.self).filter("id = '\(appID)'").first {
            return app
        }
        
        let app = App()
        app.id = appID
        app.name = appName
        app.path = appPath
        DataCenter.instance.add(object: app)
        return app
    }
}

extension App {
    public static func ==(lhs: App, rhs: App) -> Bool {
        return lhs.id == rhs.id
    }
}
