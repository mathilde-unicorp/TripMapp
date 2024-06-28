//
//  UIWindow+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/06/2024.
//

import SwiftUI

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }

            return windowScene.windows.first(where: { $0.isKeyWindow })
        }
        return nil
    }
}
