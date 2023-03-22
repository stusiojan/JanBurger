//
//  ContentView.swift
//  JanBurger
//
//  Created by Jan Stusio on 21/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        Picker("Select your burger", selection:  $order.type) {
                            ForEach(Order.types.indices, id: \.self) {
                                Text(Order.types[$0])
                            }
                        }
                        
                        Stepper("Number of burgers: \(order.quantity)", value: $order.quantity, in: 1...10)
                    }
                    .listRowBackground(Color.orange)
                    
                    Section {
                        Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                        
                        if order.specialRequestEnabled {
                            Toggle("Extra cheese", isOn: $order.extraCheese)
                            Toggle("Extra beef", isOn: $order.extraBeef)
                        }
                    }
                    .listRowBackground(Color.orange)
                    
                    Section {
                        NavigationLink {
                            AddressView(order: order)
                        } label: {
                            Text("Where to?")
                        }
                    }
                    .listRowBackground(Color.orange)
                }
                .scrollContentBackground(.hidden)
                .overlay(
                    VStack(spacing: 5) {
                        Spacer()
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 90)
                            .foregroundColor(.clear)
                            .overlay(
                                Capsule()
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .foregroundColor(.orange)
                                , alignment: .top)
                            .overlay(
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 65)
                                    .foregroundColor(.orange)
                                , alignment: .bottom)
                            .overlay(
                                Text("Jan")
                                    .font(.largeTitle) +
                                Text("burger")
                                    .font(.largeTitle)
                                    .bold()
                                , alignment: .center)
                        
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 20)
                            .foregroundColor(.red)
                        
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 10)
                            .foregroundColor(.green)
                        
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .foregroundColor(.brown)
                        
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .foregroundColor(.clear)
                            .overlay(
                                Rectangle()
                                    .frame(maxWidth: .infinity, minHeight: 10, maxHeight: 35)
                                    .foregroundColor(.orange)
                                , alignment: .top)
                            .overlay(
                                Capsule()
                                    .frame(maxWidth: .infinity, minHeight: 10, maxHeight: 50)
                                    .foregroundColor(.orange)
                                , alignment: .bottom)
                    }
                        .padding([.leading, .bottom, .trailing], 10)
                )
            }
            .background(Color.yellow)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
