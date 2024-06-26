//
//  GlowingRectangle.swift
//  LiveWpp
//
//  Created by Ces Mejia on 17/01/24.
//

import SwiftUI

struct GlowingRectangle: View {
    let color: Color
    let frame: CGSize
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundStyle(color)
                .shadow(color: color, radius: 25)
                .frame(width: frame.width, height: frame.height)
        }
//        .frame(width: frame.width + 10, height: frame.height + 10)
    }
}

#Preview {
    GlowingRectangle(color: .cyan, frame: CGSize(width: 100, height: 100))
        .border(.red)
}

#Preview {
    GlowingRectangle(color: .cyan, frame: CGSize(width: 10, height: 10))
        .border(.red)
}
