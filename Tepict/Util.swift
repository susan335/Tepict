//
//  Util.swift
//  Tepict
//
//  Created by Yohta Watanave on 2020/02/24.
//  Copyright © 2020 Yohta Watanave. All rights reserved.
//

import Cocoa

func getTerminalAppWindowRect() -> CGRect {
    let terminalApp = NSWorkspace.shared.runningApplications.first { (runApp) -> Bool in
        runApp.bundleIdentifier == TerminalAppBundleId
    }!
    
    guard let windowList: NSArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) else {
        fatalError()
    }
    let windowRect = (windowList as! [NSDictionary])
        .filter { $0[kCGWindowOwnerPID] as! Int32 == terminalApp.processIdentifier }
        .map { windowDic -> CGRect in
            let windowBounds = windowDic[kCGWindowBounds] as! CFDictionary
            return CGRect(dictionaryRepresentation: windowBounds) ?? .zero
        }
        .filter { $0.width > 100 && $0.height > 100 }
    
    return windowRect.first ?? .zero
}

func getPreviewWindowRect() -> CGRect {
    let terminalAppWindowRect = getTerminalAppWindowRect()
    let mainScreenFrame = NSScreen.main!.frame
    print("terminalAppWindowRect = \(terminalAppWindowRect)")
    print("screenFrame = \(mainScreenFrame)")
    let primaryScreenFrame = NSScreen.screens.first!.frame
    print("primaryScreenFrame = \(primaryScreenFrame)")
    let offsetY = mainScreenFrame.minY >= 0 ? 0 : primaryScreenFrame.height - mainScreenFrame.height
    let rect: NSRect
    let userData = UserData()
    switch userData.previewLocation {
    case .full:
        rect = terminalAppWindowRect
    case .top:
        rect = NSRect(x: terminalAppWindowRect.minX,
                      y: terminalAppWindowRect.minY,
                      width: terminalAppWindowRect.width,
                      height: terminalAppWindowRect.height / 2)
    case .bottom:
        rect = NSRect(x: terminalAppWindowRect.minX,
                      y: terminalAppWindowRect.midY,
                      width: terminalAppWindowRect.width,
                      height: terminalAppWindowRect.height / 2)
    case .left:
        rect = NSRect(x: terminalAppWindowRect.minX,
                      y: terminalAppWindowRect.minY,
                      width: terminalAppWindowRect.width / 2,
                      height: terminalAppWindowRect.height)
    case .right:
        rect = NSRect(x: terminalAppWindowRect.midX,
                      y: terminalAppWindowRect.minY,
                      width: terminalAppWindowRect.width / 2,
                      height: terminalAppWindowRect.height)
    }
    
    let affineTransform = CGAffineTransform(translationX: 0, y: mainScreenFrame.height)
        .scaledBy(x: 1, y: -1)
        .translatedBy(x: 0, y: -offsetY)
    var previewWindowFrame = rect.applying(affineTransform)
    let leftOffset = CGFloat(Float(userData.leftOffset) ?? 0)
    let topOffset = CGFloat(Float(userData.topOffset) ?? 0)
    let rightOffset = CGFloat(Float(userData.rightOffset) ?? 0)
    let bottomOffset = CGFloat(Float(userData.bottomOffset) ?? 0)
    previewWindowFrame.origin.x += leftOffset
    previewWindowFrame.size.width -= leftOffset
    previewWindowFrame.size.width -= rightOffset
    previewWindowFrame.origin.y += bottomOffset
    previewWindowFrame.size.height -= bottomOffset
    previewWindowFrame.size.height -= topOffset
    
    return previewWindowFrame
}
