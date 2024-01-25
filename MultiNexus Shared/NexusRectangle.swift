//
//  NexusRectangle.swift
//  LiveWpp
//
//  Created by Ces Mejia on 17/01/24.
//

import SwiftUI

struct NexusRectangle: View {
    let color: Color
    let frame: CGSize
    
    var body: some View {
        VStack(spacing: -25) {
            GlowingRectangle(color: color, frame: CGSize(width: frame.width, height: frame.width))
            RectangleTail(color: color, frame: CGSize(width: frame.width, height: frame.width * 10))
        }
    }
}

#Preview {
    NexusRectangle(color: .cyan, frame: CGSize(width: 50, height: 50))
}

#Preview {
    NexusRectangle(color: .cyan, frame: CGSize(width: 10, height: 10))
}
