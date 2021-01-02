//
//  Store.swift
//  Frugalee
//
//  Created by Jakub Kornatowski on 02/01/2021.
//

import Foundation
import Combine

final class Store: ObservableObject {
    @Published private(set) var state: AppState
    let reducer: Reducer<AppState, AppAction>
    var cancellable: AnyCancellable? = nil
    
    init(
        state: AppState = .init(spendings: []),
        reducer: @escaping Reducer<AppState, AppAction>
    ){
        self.state = state
        self.reducer = reducer
        
        self.cancellable = state.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
    }
    
    func send(_ action: AppAction) {
        reducer(&state, action)
    }
}
