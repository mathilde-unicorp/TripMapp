//
//  ActionableObject.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/02/2024.
//

import Foundation

protocol ActionableObject: ObservableObject {
    associatedtype Output

    var state: LoadingState<Output> { get }

    func action()
}
