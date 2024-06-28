//
//  UIScreen+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/06/2024.
//

import SwiftUI

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
