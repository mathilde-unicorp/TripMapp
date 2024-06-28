//
//  BorderedView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 19/02/2024.
//

import SwiftUI

struct BorderShadowViewModifier<S: ShapeStyle>: ViewModifier {
    let corderRadius: CGFloat
    let shapeStyle: S

    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                in: RoundedRectangle(cornerRadius: 12.0)
            )
            .backgroundStyle(
                shapeStyle.shadow(.drop(radius: 8.0, x: 2, y: 2))
            )
    }
}

extension View {
    @ViewBuilder
    func borderShadow<S: ShapeStyle>(
        cornerRadius: CGFloat = 12.0,
        shapeStyle: S = .bar
    ) -> some View {
        self.modifier(BorderShadowViewModifier(
            corderRadius: cornerRadius,
            shapeStyle: shapeStyle
        ))
    }
}

#Preview {
    Text("_example_long_text")
        .borderShadow()
}
