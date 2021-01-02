//
//  AppAction.swift
//  Frugalee
//
//  Created by Jakub Kornatowski on 02/01/2021.
//

import Foundation

enum AppAction {
    case onAppear
    case add(newValue: Spending)
    case check(value: Spending)
    case remove(at: Int)
    case removeAll
}
