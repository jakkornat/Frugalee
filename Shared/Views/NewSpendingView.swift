//
//  NewSpendingView.swift
//  Frugalee
//
//  Created by Jakub Kornatowski on 01/01/2021.
//

import SwiftUI

struct NewSpendingView: View {
    @ObservedObject var store: Store
    @State var title: String = ""
    @State var amount: String = ""
    @State var addedAlertPresented: Bool = false
    @State var date: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Form {
                    TextField("Spending title", text: $title)
                        .keyboardType(.default)
                        .padding([.leading, .trailing], 10)
                    HStack {
                        TextField("Amount", text: $amount)
                            .keyboardType(.numbersAndPunctuation)
                            .padding([.leading, .trailing], 10)
                        Spacer()
                        Text("zł")
                    }
                    DatePicker("", selection: $date, displayedComponents: [.date])
                        .padding([.leading, .trailing], 10)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                Button("Add") {
                    guard !(title.isEmpty || amount.isEmpty) else { return }
                    let newValue = Spending(title: title, amount: amount, date: date)
                    store.send(.add(newValue: newValue))
                    addedAlertPresented.toggle()
                }
                .padding()
            }
            .navigationTitle("Add new spending")
        }
        .alert(isPresented: $addedAlertPresented,
               content: {
                    Alert(title: Text("Success 🙌"),
                          message: Text("Spending for \"\(title)\" has been successfully added."),
                          dismissButton: .cancel(Text("OK")) {
                            title = ""
                            amount = ""
                          })
               }
        )
    }
}
