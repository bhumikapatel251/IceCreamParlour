//
//  Home.swift
//  IceCreamParlour
//
//  Created by Bhumika Patel on 08/09/22.
//

import SwiftUI

struct Home: View {
    //MARK: View Property
    @State var currentIndex: Int = 0
    @Namespace var animation
    var body: some View {
        ZStack{
           
            background.ignoresSafeArea()
            VStack{
                HeaderView()
                //AttributedText
                VStack(alignment: .leading, spacing: 8) {
                    Text(attributedTitle)
                        .font(.largeTitle).bold()
                    Text(attributedSubTitle)
                        .font(.largeTitle).bold()
                }
                .padding(.horizontal,15)
                .frame(maxWidth: .infinity, alignment: .leading)
                GeometryReader{proxy in
                    let size = proxy.size
                    CarouselView(size: size)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
          
        }
    }
    //MARK: CustomCarousel
    @ViewBuilder
    func CarouselView(size: CGSize)->some View {
        VStack(spacing: -40){
            CustomCarousel(index: $currentIndex, items: milkShakes, spacing: 0, cardPadding: size.width / 3, id: \.id) { milkshake, _ in
                 // MARK: previous Issue
                VStack(spacing: 10){
                    Image(milkshake.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(.init(degrees: -2))
                        .background{
                            RoundedRectangle(cornerRadius: size.height / 10, style: .continuous)
                                .fill(Color("G1"))
                                .padding(.top,0)
                                .padding(.horizontal,-0)
                                .offset(y: -10)
                        }
                    Text(milkshake.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.top,8)
                    Text(milkshake.price)
                        .font(.callout)
                        .fontWeight(.black)
                        .foregroundColor(Color("G2"))
                }
                
            }
            .frame(height: size.height * 0.8)
            Indicators()
        }
        .frame(width: size.width, height: size.height, alignment: .bottom)
        .padding(.bottom,8)
        //MARK: Custom Arc background
        .background{
           CustomArcShape()
                .fill(Color.white)
                .overlay(alignment: .topLeading, content: {
                    TabMenu()
                })
                .padding(.top,40)
                .ignoresSafeArea()
        }
    }
    //MARK: Custome tabmenu
    @ViewBuilder
    func TabMenu()->some View{
        HStack(spacing: 30){
            ForEach(tabs){tab in
                Image(tab.tabName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 50)
                    .padding(10)
                    .background{
                        Circle()
                            .fill(Color("G1"))
                            
                    }
                //MARK: I already pre-defined the offsets to make them look like Circular
                    .offset(tab.tabOffset)
            }
           
        }
        .padding(15)
    }
    //MARK: Indicator
    @ViewBuilder
    func Indicators()-> some View{
        HStack(spacing: 2){
            ForEach(milkShakes.indices,id: \.self){index in
                Circle()
                    .fill(Color("G2"))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
                    .padding(4)
                    .background{
                        if currentIndex == index{
                            Circle().stroke(Color("G2"),lineWidth: 1)
                                .matchedGeometryEffect(id: "INDICATOR", in: animation)
                        }
                    }
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
    
    //MARK: Header view
    @ViewBuilder
    func HeaderView()->some View{
        HStack{
            Button{
                
            } label: {
                HStack(spacing: 10){
                    Image("Pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    Text("Frenk Leng")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                }
                .padding(.leading,8)
                .padding(.horizontal,12)
                .padding(.vertical,6)
                .background{
                    Capsule()
                        .fill(Color("G1"))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Button{
                
            } label: {
                Image(systemName: "cart")
                    .font(.title2)
                    .foregroundColor(.black)
                    .overlay(alignment: .topTrailing){
                        Circle()
                            .fill(.red)
                            .frame(width: 10, height: 10)
                            .offset(x:2, y:-5)
                    }
            }
        }
        .padding(15)
    }
    var attributedTitle: AttributedString{
        var attString = AttributedString(stringLiteral: "Good Food,")
        if let rang = attString.range(of: "Food,"){
            attString[rang].foregroundColor = .white
        }
        return attString
    }
    var attributedSubTitle: AttributedString{
        var attString = AttributedString(stringLiteral: "Good Mood.")
        if let rang = attString.range(of: "Good"){
            attString[rang].foregroundColor = .white
        }
        return attString
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
