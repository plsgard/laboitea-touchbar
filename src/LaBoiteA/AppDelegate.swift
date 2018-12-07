//
//  AppDelegate.swift
//  LaBoiteA
//
//  Created by Pier-Lionel Sgard on 06/12/2018.
//  Copyright © 2018 Diple. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if #available(OSX 10.12.1, *) {
            NSApplication.shared.isAutomaticCustomizeTouchBarMenuItemEnabled = true
        }
        
        if let button = statusItem.button {
            let icon = NSImage(named:NSImage.Name("Logo"))
            icon?.isTemplate = true
            button.image = icon
            //button.action = #selector(printQuote(_:))
        }
        
        constructMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Quit LBA", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }

}

