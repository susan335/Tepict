//
//  ImagePreviewView.swift
//  Tepict
//
//  Created by Yohta Watanave on 2020/02/24.
//  Copyright © 2020 Yohta Watanave. All rights reserved.
//

import SwiftUI

struct ImagePreviewView: View {
    let nsImage: NSImage?
    
    init(imagePath: String) {
        self.nsImage = NSImage(contentsOfFile: imagePath)
    }
    
    var body: some View {
        Group {
            if self.nsImage != nil {
                Image(nsImage: nsImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            else {
                Text("Image loading failed.")
            }
        }
    }
}

struct ImagePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreviewView(imagePath: "/tmp/kanna.png")
    }
}
