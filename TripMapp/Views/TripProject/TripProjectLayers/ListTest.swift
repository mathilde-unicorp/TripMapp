//
//  ListTest.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/07/2024.
//

import SwiftUI

struct ListTest: View {
    @State var items = [0, 1, 2, 3, 4]

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                let index = items.firstIndex(of: item)!
                Text("\(items[index])")
            }
            .onMove(perform: { indices, newOffset in
                items.move(fromOffsets: indices, toOffset: newOffset)
            })
        }.toolbar(content: {
            EditButton()
        })
    }
}

#Preview {
    NavigationView {
        ListTest()
    }
}
