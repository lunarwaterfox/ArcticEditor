//
//  ViewController.swift
//  ArcticEditor
//
//  Created by lcl on 2019/5/27.
//  Copyright © 2019 vuples. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var editor: ArcticEditor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        editor.text = "hello\na"
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

