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
    @State var currentTab: Tab = tabs[1]
    //MARK: detail view property
    @State var selectedMilkShake: MilkShake?
    @State var showDetail: Bool = false
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
                .opacity(showDetail ? 0 : 1)
                GeometryReader{proxy in
                    let size = proxy.size
                    CarouselView(size: size)
                }
                .zIndex(-10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .overlay(content: {
                if let selectedMilkShake1 = selectedMilkShake, showDetail {
                    DetailView(animation: animation, milkShake: selectedMilkShake1  , show: $showDetail)
                    
                } else {
                    
                }
            })
//            .overlay(content: {
//                if let selectedMilkShake,showDetail{
//                    DetailView(animation: animation, milkShake: selectedMilkShake, show: $showDetail)
//                }
//            })
        }
    }
    //MARK: CustomCarousel
    @ViewBuilder
    func CarouselView(size: CGSize)->some View {
        VStack(spacing: -40){
            CustomCarousel(index: $currentIndex, items: milkShakes, spacing: 0, cardPadding: size.width / 3, id: \.id) { milkshake, _ in
                 // MARK: previous Issue
                VStack(spacing: 10){
                    //MARK: Applying matched geometry
                    ZStack{
                        if showDetail && selectedMilkShake?.id == milkshake.id{
                            Image(milkshake.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                                .opacity(0)
                        }else{
                            Image(milkshake.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                                .matchedGeometryEffect(id: milkshake.id, in: animation)
                        }
                    }
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
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)){
                        selectedMilkShake = milkshake
                        showDetail = true
                        
                    }
                }
                
            }
            .frame(height: size.height * 0.8)
            Indicators()
        }
        .frame(width: size.width, height: size.height, alignment: .bottom)
        .padding(.bottom,8)
        .opacity(showDetail ? 0 : 1)
        //MARK: Custom Arc background
        .background{
           CustomArcShape()
                .fill(Color.white)
                .scaleEffect(showDetail ? 1.8 : 1, anchor: .bottomLeading)
                .overlay(alignment: .topLeading, content: {
                    TabMenu()
                        .opacity(showDetail ? 0 : 1)
                })
                .padding(.top,40)
                .ignoresSafeArea()
               // .zIndex(-10)
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
                    .background(content: {
                        Circle()
                            .fill(.white)
                            .padding(-2)
                    })
                    .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
                //MARK: I already pre-defined the offsets to make them look like Circular
                    .offset(tab.tabOffset)
                    .scaleEffect(currentTab.id == tab.id ? 1.15 : 0.9, anchor: .bottom)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            currentTab = tab
                        }
                    }
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
            .opacity(showDetail ? 0 : 1)
            //MARK: going to same button  for home view
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
struct DetailView: View {
    var animation: Namespace.ID
    var milkShake: MilkShake
    @Binding var show: Bool
    
    //MARK: View property
    @State var orderType: String = "Active Order"
    @State var showContent: Bool = false
    var body: some View {
        VStack{
            HStack{
                Button{
                    withAnimation(.easeInOut(duration: 0.35)){
                        show = false
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .overlay{
                Text("Details")
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            .padding(.top, 7)
            .opacity(showContent ? 1 : 0)
            
            HStack(spacing: 0){
                ForEach(["Active Order", "PastOrder"],id: \.self){order in
                    Text(order)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(orderType == order ? .black : .gray)
                        .padding(.horizontal,20)
                        .padding(.vertical,10)
                        .background{
                            if orderType == order{
                                Capsule()
                                    .fill(Color("G1"))
                                    .matchedGeometryEffect(id: "ORDERTAB", in: animation)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut){orderType = order}
                        }
                    
                }
                
            }
            .padding(.leading,15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            .opacity(showContent ? 1 : 0)
            
            Image(milkShake.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(.init(degrees: -2))
                .matchedGeometryEffect(id: milkShake.id, in: animation)
            GeometryReader{proxy in
                let size = proxy.size
                IceCreamDetail()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .transition(.asymmetric(insertion: .identity, removal: .offset(y: 0.5)))
        .onAppear{
            withAnimation(.easeInOut.delay(0.1)){
            showContent = true
            }
        }
    }
    // Custome bottom sheet
    @ViewBuilder
    func IceCreamDetail()->some View{
        VStack{
            VStack(spacing: 12){
                Text("#512D Code")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Text(milkShake.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text(milkShake.price)
                    .font(.callout)
                    .fontWeight(.black)
                    .foregroundColor(Color("G2"))
                Text("20min delivery")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                HStack(spacing: 12){
                    Image("Quantity: ")
                        .font(.callout.bold())
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "minus")
                            .font(.title3)
                        
                    }
                    Text("\(2)")
                        .font(.title3)
                    
                    Button{
                        
                    } label: {
                       Image(systemName: "plus")
                            .font(.title3)
                    }
                }
                .foregroundColor(.gray)
                Button{
                    
                } label: {
                    Text("Add to Cart")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.horizontal,25)
                        .padding(.vertical,10)
                        .foregroundColor(.black)
                        .background{
                            Capsule()
                                .fill(Color("G2"))
                        }
                }
                .padding(.top,10)
            }
            .padding(.vertical,20)
            .frame(maxWidth:.infinity)
            .background{
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .fill(Color("G1"))
            }
            .padding(.horizontal,60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

