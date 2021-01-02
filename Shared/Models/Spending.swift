//
//  Spending.swift
//  Frugalee
//
//  Created by Jakub Kornatowski on 02/01/2021.
//

import Foundation

struct Spending: Equatable, Codable, Identifiable {
    var id: UUID = UUID()
    var title: String
    var amount: String
    var date: Date
    var addedToFile: Bool = false
    var readableDate: String {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        return df.string(from: date)
    }
}
