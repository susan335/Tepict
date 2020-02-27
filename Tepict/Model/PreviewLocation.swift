//
//  PreviewLocation.swift
//  Tepict
//
//  Created by Yohta Watanave on 2020/02/24.
//  Copyright © 2020 Yohta Watanave. All rights reserved.
//

import Foundation

enum PreviewLocation: String, Identifiable {
    
    var id: String {
        return self.rawValue
    }
    
    case left
    case top
    case right
    case bottom
    case full
}
