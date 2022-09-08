//
//  Home.swift
//  IceCreamParlour
//
//  Created by Bhumika Patel on 08/09/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack{
            background.ignoresSafeArea()
        }
    }
    var background: some View {
        ZStack{
            AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5928403806, green: 0.6960029987, blue: 0.5323166828, alpha: 1)),Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)),Color(#colorLiteral(red: 0.6082496155, green: 0.6862257828, blue: 0.4985613901, alpha: 1)),Color(#colorLiteral(red: 0.6082496155, green: 0.6862257828, blue: 0.4985613901, alpha: 1))]), center: .center, angle: .degrees(120))
            
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(1.5), Color.white.opacity(0.5)]), startPoint: .bottom, endPoint: .top)
           
           
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
