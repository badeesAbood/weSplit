//
//  ContentView.swift
//  WeSplit
//
//  Created by MASARAT on 30/9/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var keyBoardfocust: Bool
    var amountPerPerson : (total: Double , person: Double ) {
        let people = Double(numberOfPeople + 2)
        
        let totalAmount = (checkAmount/100) * Double(tipPercentage) + checkAmount
        let amountPerPerson = totalAmount / people
        return (totalAmount , amountPerPerson)
    }
    
    let tipPercentages = [5, 10 ,15 ,20 ]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount" , value: $checkAmount , format: .currency(code: Locale.current.currency?.identifier  ?? "LYD")).keyboardType(.decimalPad).focused($keyBoardfocust)
                    
                    Picker("Number of People" , selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip ?") {
                    Picker("Tip Percentage" , selection: $tipPercentage){
                        ForEach(0..<101 , id: \.self){
                            Text($0 ,format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("Amount per Person") {
                    Text(amountPerPerson.person , format:  .currency(code: Locale.current.currency?.identifier ?? "LYD"))
                }
                
                Section("Total Amount"){
                    Text(amountPerPerson.total, format: .currency(code: Locale.current.currency?.identifier ?? "LYD"))
                }
            }.navigationTitle("WeSplit").toolbar {
                if keyBoardfocust {
                    Button("Done") {
                        keyBoardfocust = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
