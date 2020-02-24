//
//  Util.swift
//  Tepict
//
//  Created by Yohta Watanave on 2020/02/24.
//  Copyright © 2020 Yohta Watanave. All rights reserved.
//

import Cocoa

func getTerminalAppWindowRect() -> CGRect {
    guard let windowList: NSArray = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) else {
        fatalError()
    }
    let windowRect = (windowList as! [NSDictionary])
        .filter { $0[kCGWindowOwnerName] as! NSString == "ターミナル" }
        .map { windowDic -> CGRect in
            let windowBounds = windowDic[kCGWindowBounds] as! CFDictionary
            return CGRect(dictionaryRepresentation: windowBounds) ?? .zero
        }
        .filter { $0.width > 100 && $0.height > 100 }
    
    return windowRect.first ?? .zero
}

func getPreviewWindowRect() -> CGRect {
    let terminalAppWindowRect = getTerminalAppWindowRect()
    let screenFrame = NSScreen.main!.frame
    print("screenFrame = \(screenFrame)");
    let rect = NSRect(x: terminalAppWindowRect.minX + terminalAppWindowRect.width / 2,
                      y: terminalAppWindowRect.minY,
                      width: terminalAppWindowRect.width / 2,
                      height: terminalAppWindowRect.height)
    
    let margin: CGFloat = 10
    let offset: CGFloat = 50
    let affineTransform = CGAffineTransform(translationX: 0, y: screenFrame.height)
        .scaledBy(x: 1, y: -1)
        .translatedBy(x: 0, y: offset + (margin / 2))
    return rect.applying(affineTransform)
        .insetBy(dx: margin, dy: offset + margin)
}
