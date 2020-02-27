//
//  UserData.swift
//  Tepict
//
//  Created by Yohta Watanave on 2020/02/24.
//  Copyright © 2020 Yohta Watanave. All rights reserved.
//

import SwiftUI
import Combine
import SmartUserDefaults

class UserData: ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefaultsEnumProperty(key: "previewLocation", defaultValue: .full)
    var previewLocation: PreviewLocation {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefaultsProperty(key: "leftOffset", defaultValue: 0)
    var leftOffset: CGFloat {
        willSet {
            objectWillChange.send()
        }
    }
//    @Published var topOffset: CGFloat
//    @Published var rightOffset: CGFloat
//    @Published var bottomOffset: CGFloat
//    
}
