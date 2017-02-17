//
//  AppDelegate.swift
//  Chronus
//
//  Created by Shao Tianchi on 2017/1/13.
//  Copyright © 2017年 Shao Tianchi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var statusMenu: NSMenu! = {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Pause", action: #selector(pause), keyEquivalent: "p"))
        menu.addItem(NSMenuItem(title: "Report", action: #selector(showReport), keyEquivalent: "r"))
        return menu
    }()
    
    var statusItem: NSStatusItem!
    
    var reportWindowController: NSWindowController! = {
        let reportWindow = NSStoryboard(name: "Report", bundle: nil).instantiateController(withIdentifier: "ReportWindow") as! NSWindowController
        return reportWindow
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        DataCenter.instance.setup()
        
        statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        self.statusItem.menu = statusMenu
        statusItem.title = "Chronus"
        statusItem.highlightMode = true
        
        addObservers()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

extension AppDelegate {
    func addObservers() {
        NSWorkspace.shared().notificationCenter.addObserver(self, selector: #selector(handleLaunch(_:)), name: NSNotification.Name.NSWorkspaceDidLaunchApplication, object: nil)
        NSWorkspace.shared().notificationCenter.addObserver(self, selector: #selector(handleActive(_:)), name: NSNotification.Name.NSWorkspaceDidActivateApplication, object: nil)
    }
    
    func handleLaunch(_ notification: Any?) {
//        guard let app = appInfo(by: notification) else {
//            return
//        }
        
//        CCTV.instance.handleAppLaunch(app: app)
    }
    
    func handleActive(_ notification: Any?) {
        guard let app = appInfo(by: notification) else {
            return
        }
        
        CCTV.instance.handleAppActive(app: app)
    }
    
    private func appInfo(by notification: Any?) -> App? {
        guard let notification = notification,
            let userInfo = (notification as? NSNotification)?.userInfo as? [String : Any] else {
                return nil
        }
        
        let app = userInfo["NSWorkspaceApplicationKey"] as! NSRunningApplication
        
        return App.setup(runningApplication: app)
    }
}

extension AppDelegate {
    func pause() {
        
    }
    
    func showReport() {
        reportWindowController.showWindow(self)
        reportWindowController.window?.makeKeyAndOrderFront(self)
        NSApp.activate(ignoringOtherApps: true)
    }
}
