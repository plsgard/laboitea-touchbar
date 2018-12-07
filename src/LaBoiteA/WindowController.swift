//
//  MainWindowController.swift
//  LaBoiteA
//
//  Created by Pier-Lionel Sgard on 06/12/2018.
//  Copyright © 2018 Diple. All rights reserved.
//


import Cocoa
import AVFoundation

class WindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @available(OSX 10.12.1, *)
    override func makeTouchBar() -> NSTouchBar? {
        guard let viewController = contentViewController as? ViewController else {
            return nil
        }
        return viewController.makeTouchBar()
    }
}
