//
//  ContentView.swift
//  Shared
//
//  Created by Jakub Kornatowski on 01/01/2021.
//

import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var store: Store
    @State private var sheetPresented: Bool = false
    @State private var removeAllAlertPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.state.spendings.sorted(by: { $0.date > $1.date })) { (spending) in
                    HStack {
                        Image(systemName: spending.addedToFile ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(spending.title)
                            Text(spending.readableDate)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("\(spending.amount) zł")
                    }
                    .onTapGesture { store.send(.check(value: spending)) }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        store.send(.remove(at: index))
                    }
                })
            }
            .navigationTitle("Hello")
            .navigationBarItems(
                leading: Button(action: {
                    if !store.state.spendings.isEmpty {
                        removeAllAlertPresented = true
                    }
                }, label: {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red)
                }), trailing: Button(action: {
                    sheetPresented.toggle()
                }, label: {
                    Image(systemName: "cart.badge.plus")
                })
            )
            .sheet(isPresented: $sheetPresented,
                   onDismiss: { self.sheetPresented = false },
                   content: { NewSpendingView(store: store) }
            )
            .alert(isPresented: $removeAllAlertPresented, content: {
                Alert(
                    title: Text("Removing all..."),
                    message: Text("Are you sure to remove all? 🤔"),
                    primaryButton: .default(Text("Yup"), action: {
                        store.send(.removeAll)
                    }),
                    secondaryButton: .cancel(Text("Cancel"), action: {
                        removeAllAlertPresented = false
                    })
                    )
            })
        }
        .onAppear { store.send(.onAppear) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppState(spendings: .init()))
    }
}
