//
//  TripProjectNameAndImageSection.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/05/2024.
//

import SwiftUI

struct TripProjectNameAndImageSection: View {
    @Binding var name: String

    let imageHeight: CGFloat

    var body: some View {
        Section {
            FormField("project_name") {
                TextField("project_name_example", text: $name)
            }
        } header: {
            Image("ProjectImagePlaceholder")
                .resizable()
                .scaledToFill()
                .listRowInsets(EdgeInsets(top: 8, leading: -24, bottom: 8, trailing: -24))
                .frame(minHeight: 200.0, idealHeight: imageHeight)
                .clipped()
                .padding(.bottom)
                .overlay(alignment: .center) {
                    Button(action: {
                        print("select among many others")
                    }, label: {
                        Image(systemName: "photo.fill")
                            .clipToCircle(backgroundColor: .blue)
                            .foregroundStyle(.white)
                            .shadow(radius: 10)
                    })
                    .padding(.trailing)
                    .padding(.bottom, 32.0)
                }
        }
    }
}

#Preview {
    TripProjectNameAndImageSection(name: .constant(""), imageHeight: 200.0)
}
