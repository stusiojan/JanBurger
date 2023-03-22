//
//  CheckoutView.swift
//  JanBurger
//
//  Created by Jan Stusio on 21/03/2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var conformationMessage = ""
    @State private var showingConformation = false
    @State private var showingOrderAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://static.wikia.nocookie.net/spongebob/images/d/d4/Plabs_Burger.png/revision/latest/scale-to-width-down/1000?cb=20150328192722")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 330)
            }
            Text("Source: Nickelodeon")
                .font(.system(size: 10))
                .fontWeight(.light)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .bottom])
            
            Text("Total: ")
                .font(.title) +
            Text(order.cost, format: .currency(code: "USD"))
                .font(.title)
                .bold()
            
            Button("Order") {
                Task {
                    await orderBurger()
                }
            }
                .padding()
                .foregroundColor(.black)
                .background(Color.orange)
                .clipShape(Capsule())
        }
        .background(Color.yellow)
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Smart choise!", isPresented:  $showingConformation) {
            Button("OK") { }
        } message: {
            Text(conformationMessage)
        }
        .alert("Error", isPresented: $showingOrderAlert) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    func orderBurger() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Oops, encoding has failed")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/burgers")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            conformationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) is on its way!"
            showingConformation = true
        } catch {
            errorMessage = "Checkout failed"
            showingOrderAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
