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
    var previewPanel: NSPanel?
    var preferenceWindow: NSWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.statusItem.button?.title = "TP"
        self.statusItem.menu = self.menu
        
        self.subscribeDistributedNotifications()
        self.subscribeWorkspaceNotifications()
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        DistributedNotificationCenter.default().suspended = false
    }
    
    private func subscribeDistributedNotifications() {
        DistributedNotificationCenter.default().addObserver(
            forName: ShowImageNotification,
            object: NotificationSender,
            queue: nil) { notification in
                print("show")
                self.previewPanel?.close()
                let previewView = ImagePreviewView(imagePath: notification.userInfo![imagePathKey] as! String)
                let panel = NSPanel(contentRect: getPreviewWindowRect(),
                                    styleMask: .nonactivatingPanel,
                                    backing: .buffered,
                                    defer: true)
                panel.level = NSWindow.Level.floating
                panel.contentView = NSHostingView(rootView: previewView)
                panel.makeKeyAndOrderFront(nil)
                self.previewPanel = panel
        }
        DistributedNotificationCenter.default().addObserver(
            forName: DismissNotification,
            object: NotificationSender,
            queue: nil) { notification in
                print("close")
                self.previewPanel?.close()
                self.previewPanel = nil
        }
    }
    
    private func subscribeWorkspaceNotifications() {
        NSWorkspace.shared.notificationCenter
            .addObserver(forName: NSWorkspace.didActivateApplicationNotification,
                         object: nil,
                         queue: nil) { notification in
                            let runningApplication = notification.userInfo?["NSWorkspaceApplicationKey"] as! NSRunningApplication
                            if runningApplication.bundleIdentifier == TerminalAppBundleId {
                                self.previewPanel?.makeKeyAndOrderFront(nil)
                            }
                            else {
                                self.previewPanel?.close()
                            }
                            
            }
    }
    
    @IBAction func showPreference(_ sender: Any) {
        let preferenceWindow: NSWindow
        if let window = self.preferenceWindow {
            preferenceWindow = window
        }
        else {
            var frame = NSRect.zero
            if let screenFrame = NSScreen.main?.frame {
                frame = frame.offsetBy(dx: screenFrame.midX, dy: screenFrame.midY)
            }
            preferenceWindow = NSWindow(contentRect: frame,
                                        styleMask: [.closable, .titled],
                                        backing: .buffered,
                                        defer: true)
            preferenceWindow.level = NSWindow.Level.normal
            preferenceWindow.contentView = NSHostingView(
                rootView: PreferenceView()
            )
            self.preferenceWindow = preferenceWindow
            preferenceWindow.isReleasedWhenClosed = false
            preferenceWindow.makeKey()
        }
        
        preferenceWindow.orderFrontRegardless()
    }
}

