//
//  ViewController.swift
//  Chronus
//
//  Created by Shao Tianchi on 2017/1/13.
//  Copyright © 2017年 Shao Tianchi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBAction func show(_ sender: Any) {
        print(CCTV.instance.dosage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
}

