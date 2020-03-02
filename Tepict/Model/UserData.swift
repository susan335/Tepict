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
    
    @UserDefaultsProperty(key: "leftOffset", defaultValue: "")
    var leftOffset: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefaultsProperty(key: "topOffset", defaultValue: "")
    var topOffset: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefaultsProperty(key: "rightOffset", defaultValue: "")
    var rightOffset: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefaultsProperty(key: "bottomOffset", defaultValue: "")
    var bottomOffset: String {
        willSet {
            objectWillChange.send()
        }
    }
}
