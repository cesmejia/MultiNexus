//
//  RectangleTail.swift
//  LiveWpp
//
//  Created by Ces Mejia on 17/01/24.
//

import SwiftUI

struct RectangleTail: View {
    let color: Color
    let frame: CGSize
    
    var body: some View {
        Rectangle()
            .foregroundStyle(Gradient(colors: [color, .clear]))
            .frame(width: frame.width, height: frame.height)
            .opacity(0.8)
    }
}

#Preview {
    let previewFrame = CGSize(width: 100, height: 600)
    
    return RectangleTail(color: .cyan, frame: CGSize(width: previewFrame.width, height: previewFrame.height))
        .frame(width: previewFrame.width + 50, height: previewFrame.height + 50)
}
