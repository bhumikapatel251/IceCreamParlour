//
//  Tab.swift
//  IceCreamParlour
//
//  Created by Bhumika Patel on 08/09/22.
//

import SwiftUI

struct Tab:Identifiable{
    var id: String = UUID().uuidString
    var tabImage: String
    var tabName: String
    var tabOffset: CGSize
}
var tabs: [Tab] = [
    .init(tabImage: "Cold Stone Creamery", tabName: "Cold Stone Creamery", tabOffset: CGSize(width: 0, height: -50)),
    .init(tabImage: "CookiesBar", tabName: "CookiesBar", tabOffset: CGSize(width: 0, height: -48)),
    .init(tabImage: "DoubleSaltedCaramel", tabName: "DoubleSaltedCaramel", tabOffset: CGSize(width: 0, height: -35)),
    .init(tabImage: "Vanilla Cone", tabName: "Vanilla Cone", tabOffset: CGSize(width: -12, height: 8))
]
