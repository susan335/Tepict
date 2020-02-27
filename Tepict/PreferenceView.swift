//
//  PreferenceView.swift
//  Tepict
//
//  Created by Yohta Watanave on 2020/02/24.
//  Copyright © 2020 Yohta Watanave. All rights reserved.
//

import SwiftUI

struct PreferenceView: View {
    @ObservedObject var settings = UserData()
    
    var body: some View {
        VStack {
            Picker(selection: $settings.previewLocation, label: Text("Preview Location")) {
                ForEach([
                    PreviewLocation.full,
                    PreviewLocation.left,
                    PreviewLocation.top,
                    PreviewLocation.right,
                    PreviewLocation.bottom
                ]) { location in
                    Text(location.rawValue.uppercased()).tag(location)
                }
            }
            .pickerStyle(RadioGroupPickerStyle())
            
            Spacer().frame(height: 40)
            
//            HStack {
//                Text("Left offset: ")
//                    .frame(width: 100, alignment: .trailing)
//                TextField("0px", text: $settings.leftOffset)
//                    .frame(width: 100, alignment: .leading)
//            }
//            HStack {
//                Text("Top offset: ")
//                    .frame(width: 100, alignment: .trailing)
//                TextField("0px", text: $leftOffset)
//                    .frame(width: 100, alignment: .leading)
//            }
//            HStack {
//                Text("Right offset: ")
//                    .frame(width: 100, alignment: .trailing)
//                TextField("0px", text: $leftOffset)
//                    .frame(width: 100, alignment: .leading)
//            }
//            HStack {
//                Text("Bottom offset: ")
//                    .frame(width: 100, alignment: .trailing)
//                TextField("0px", text: $leftOffset)
//                    .frame(width: 100, alignment: .leading)
//            }
        }
        .frame(width: 300, height: 400, alignment: .center)
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
