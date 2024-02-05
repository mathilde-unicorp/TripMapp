//
//  LoadingState.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/02/2024.
//

import Foundation

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}
