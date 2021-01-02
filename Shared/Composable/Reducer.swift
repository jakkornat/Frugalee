//
//  Reducer.swift
//  Frugalee
//
//  Created by Jakub Kornatowski on 02/01/2021.
//

import Foundation

typealias Reducer<State, Action> = (_ state: inout State, _ action: Action) -> Void

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case .onAppear:
        state.load()
    case .add(let newValue):
        state.add(spending: newValue)
    case .remove(let index):
        state.remove(at: index)
    case .check(let value):
        state.check(value)
    case .removeAll:
        state.removeAll()
    }
}
