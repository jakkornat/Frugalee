//
//  FrugaleeApp.swift
//  Shared
//
//  Created by Jakub Kornatowski on 01/01/2021.
//

import SwiftUI

@main
struct FrugaleeApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(Store(reducer: appReducer(state:action:)))
        }
    }
}
