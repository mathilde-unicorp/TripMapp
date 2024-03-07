//
//  FullHeight.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import SwiftUI

extension View {
    /// Wrap the view to make it takes the full screen width
    func setFullHeight(alignment: VerticalAlignment = .top) -> some View {
        VStack {
            if alignment == .bottom || alignment == .center {
                Spacer()
            }

            self

            if alignment == .top || alignment == .center {
                Spacer()
            }
        }
        .contentShape(Rectangle())
    }
}

struct FullHeightView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Text("_example_full_height").setFullHeight()
            Text("_example_center").setFullHeight(alignment: .center)
            Text("_example_bottom").setFullHeight(alignment: .bottom)
        }
    }
}
