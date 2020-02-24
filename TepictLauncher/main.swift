//
//  main.swift
//  TepictLauncher
//
//  Created by Yohta Watanave on 2020/02/24.
//  Copyright © 2020 Yohta Watanave. All rights reserved.
//

import Foundation

if CommandLine.arguments.count < 2 {
    fatalError("""
Invalid argumemnt.
usage: TepictLauncher [-s file] [-c]
""")
}

let notificationName: Notification.Name
var userInfo = [AnyHashable: Any]()

if CommandLine.arguments[1] == "-s" {
    notificationName = ShowImageNotification
    userInfo = [imagePathKey: CommandLine.arguments[2]]
}
else if CommandLine.arguments[1] == "-c" {
    notificationName = DismissNotification
}
else {
        fatalError("""
    Invalid argumemnt.
    usage: TepictLauncher [-s file] [-c]
    """)
}

DistributedNotificationCenter
    .default()
    .post(name: notificationName,
          object: NotificationSender,
          userInfo: userInfo)

