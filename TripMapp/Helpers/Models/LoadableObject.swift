//
//  LoadableObject.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/02/2024.
//

import Foundation

protocol LoadableObject: ObservableObject {
    associatedtype Output
    
    var state: LoadingState<Output> { get }

    func load()
}
