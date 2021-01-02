//
//  AppState.swift
//  Frugalee
//
//  Created by Jakub Kornatowski on 02/01/2021.
//

import Foundation

final class AppState: ObservableObject {
    @Published var spendings: [Spending]
    
    init(spendings: [Spending]) {
        self.spendings = spendings
    }
    
    func add(spending: Spending) {
        spendings.insert(spending, at: 0)
        save()
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: "spendings"),
              let wrapped = try? JSONDecoder().decode([Spending].self, from: data) else {
            return
        }
        self.spendings = wrapped
        objectWillChange.send()
    }
    
    func remove(at index: Int) {
        spendings.remove(at: index)
        save()
    }
    
    private func save() {
        let defaults = UserDefaults.standard
        guard let data = try? JSONEncoder().encode(spendings) else { return }
        defaults.setValue(data, forKey: "spendings")
    }
    
    func check(_ spending: Spending) {
        guard let index = spendings.firstIndex(of: spending) else { return }
        spendings[index].addedToFile.toggle()
        objectWillChange.send()
        save()
    }
    
    func removeAll() {
        spendings = []
        save()
    }
}

extension AppState: Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.spendings == rhs.spendings
    }
}
