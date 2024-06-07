//
//  DeviceRotationViewModifier.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/05/2024.
//

import Foundation
import SwiftUI

/// To track rotation and call an action when a rotation occurs
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(
                for: UIDevice.orientationDidChangeNotification
            )) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onDeviceRotate(
        perform action: @escaping (UIDeviceOrientation) -> Void
    ) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

#Preview {
    Text("hello")
        .onDeviceRotate { print("Change orientation: \($0)") }
}
