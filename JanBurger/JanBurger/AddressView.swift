//
//  AddressView.swift
//  JanBurger
//
//  Created by Jan Stusio on 21/03/2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetNameAndNumber)
                TextField("City", text: $order.city)
                TextField("Zip code", text: $order.zipCode)
            }
            .listRowBackground(Color.orange)
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
            }
            .listRowBackground(Color.orange)
            .disabled(order.hasValidAddress == false)
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.yellow)
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
