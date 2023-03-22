//
//  Order.swift
//  JanBurger
//
//  Created by Jan Stusio on 21/03/2023.
//

import SwiftUI

class Order: ObservableObject, Codable { //it all can be in @Published struct and then i would list only one coding key
    enum CodingKeys: CodingKey {
        case type, quantity, extraCheese, extraBeef, name, streetNameAndNumber, city, zipCode
    }
    
    static let types = ["Hamburger", "Cheeseburger", "BLT", "Juicy Lucy", "Frita"]
    
    @Published var type = 0
    @Published var quantity = 1
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraCheese = false
                extraBeef = false
            }
        }
    }
    @Published var extraCheese = false
    @Published var extraBeef = false
    
    @Published var name = ""
    @Published var streetNameAndNumber = ""
    @Published var city = ""
    @Published var zipCode = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetNameAndNumber.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zipCode.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 5
        
        if type == 1 {
            cost += 0.5
        } else if type == 2 {
            cost += 1
        }  else if type == 3 || type == 4 {
            cost += 2
        }
        
        if extraCheese {
            cost += Double(quantity)
        }
        
        if extraBeef {
            cost += (Double(quantity) * 2)
        }
        
         return cost
    }
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraCheese, forKey: .extraCheese)
        try container.encode(extraBeef, forKey: .extraBeef)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetNameAndNumber, forKey: .streetNameAndNumber)
        try container.encode(city, forKey: .city)
        try container.encode(zipCode, forKey: .zipCode)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .type)
        
        extraCheese = try container.decode(Bool.self, forKey: .extraCheese)
        extraBeef = try container.decode(Bool.self, forKey: .extraBeef)
        
        name = try container.decode(String.self, forKey: .name)
        streetNameAndNumber = try container.decode(String.self, forKey: .streetNameAndNumber)
        city = try container.decode(String.self, forKey: .city)
        zipCode = try container.decode(String.self, forKey: .zipCode)
    }
}
