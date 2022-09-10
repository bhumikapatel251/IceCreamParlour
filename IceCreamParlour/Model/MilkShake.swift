//
//  MilkShake.swift
//  IceCreamParlour
//
//  Created by Bhumika Patel on 08/09/22.
//

import SwiftUI

//MARK: Model and sample data
struct MilkShake: Identifiable, Hashable,Equatable {
    var id: String = UUID().uuidString
    var title: String
    var price: String
    var image: String
}

var milkShakes: [MilkShake] = [
    .init(title: "Cold Stone Creamery", price: "150", image: "Cold Stone Creamery"),
    .init(title: "CookiesBar", price: "200", image: "CookiesBar"),
    .init(title: "DoubleSaltedCaramel", price: "75", image: "DoubleSaltedCaramel"),
    .init(title: "HoneyComboIceCream", price: "45", image: "HoneyComboIceCream"),
    .init(title: "Vanilla Cone", price: "30", image: "Vanilla Cone")
]
