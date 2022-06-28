//
//  Cardify.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/28/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var color: Color
    func body(content: Content) -> some View {
        
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(color)
                    .grayscale(DrawingConstants.grayScale)
                content
            } else {
                shape.fill(color)
                    .grayscale(0.1)
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 13
        static let lineWidth: CGFloat = 4
        static let grayScale: CGFloat = 0.6
        static let opacity: CGFloat = 0.5
    }
}
