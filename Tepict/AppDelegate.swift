//
//  AppDelegate.swift
//  Tepict
//
//  Created by Yohta Watanave on 2020/02/24.
//  Copyright © 2020 Yohta Watanave. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var menu: NSMenu!
    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.statusItem.button?.title = "IM"
        self.statusItem.menu = self.menu
        
        self.subscribeNotifications()
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        DistributedNotificationCenter.default().suspended = false
    }
    
    private func subscribeNotifications() {
        DistributedNotificationCenter.default().addObserver(
            forName: ShowImageNotification,
            object: NotificationSender,
            queue: nil) { notification in
                print("show")
        }
        DistributedNotificationCenter.default().addObserver(
            forName: DismissNotification,
            object: NotificationSender,
            queue: nil) { notification in
                print("close")
        }
    }
}

