//
//  CCTV.swift
//  Chronus
//
//  Created by Shao Tianchi on 2017/1/16.
//  Copyright © 2017年 Shao Tianchi. All rights reserved.
//

import Foundation
import RealmSwift

class CCTV {
    public static let instance = CCTV()
    
    var currentApp: App!
    var dosage: [String : [[String : Date]]] = [:]
    
    var apps: [App] = []
    
    func handleAppActive(app: App) {
        if !apps.contains(app) {
            apps.append(app)
        }
        
        
        try! DataCenter.instance.realm.write {
            if currentApp != nil {
                currentApp.currentInterval.end = Date()
                currentApp.timeIntervals.append(app.currentInterval)
                currentApp.currentInterval = CRNTimeInterval()
            }
            
            app.currentInterval.begin = Date()
        }
                
        currentApp = app
        
        if !apps.contains(app) {
            apps.append(app)
        }
    }
}
