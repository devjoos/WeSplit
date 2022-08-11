//
//  ContentView.swift
//  WeSplit
//
//  Created by Sam Joos on 8/2/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercent = 20
    @FocusState private var amountIsFocused : Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var currencyDisplay = FloatingPointFormatStyle<Double>.Currency
        .currency(code: Locale.current.currencyCode ?? "USD")
    var currencyDisplay2: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    var currencyDisplay3: FloatingPointFormatStyle<Double>.Currency { .currency(code: Locale.current.currencyCode ?? "USD") }
    
        
            
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercent)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        
        
        let tipSelection = Double(tipPercent)
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople, content: {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    })
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                        
                    }
                   
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(grandTotal, format: currencyDisplay)
                }
                
            header: {
                    Text("Check total")
                }
            .foregroundColor(tipPercent == 0 ? .red : .primary)
                
                Section {
                    Text(totalPerPerson, format: currencyDisplay)
                }header: {
                    Text("Amount per person")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
