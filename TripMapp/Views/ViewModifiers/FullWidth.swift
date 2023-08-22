//
//  ViewAlignment.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import SwiftUI

extension View {
    /// Wrap the view to make it takes the full screen width
    func setFullWidth(alignment: HorizontalAlignment = .leading) -> some View {
        HStack {
            if alignment == .trailing || alignment == .center {
                Spacer()
            }

            self

            if alignment == .leading || alignment == .center {
                Spacer()
            }
        }
        .contentShape(Rectangle())
    }
}

struct FullWidthView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Full width").setFullWidth()
            Text("Center").setFullWidth(alignment: .center)
            Text("Trailing").setFullWidth(alignment: .trailing)

        }
    }
}
