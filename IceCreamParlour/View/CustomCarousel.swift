//
//  CustomCarousel.swift
//  GlassLayout
//
//  Created by Bhumika Patel on 09/09/22.
//

import SwiftUI

struct CustomCarousel<Content: View,Item,ID>: View where Item: RandomAccessCollection,ID: Hashable,Item.Element:Equatable {
    var content:(Item.Element,CGSize)->Content
    var id: KeyPath<Item.Element,ID>
    
        //MARK: View properties
    var spacing: CGFloat
    var cardPadding: CGFloat
    var items: Item
    @Binding var index: Int
    init(index: Binding<Int>,items: Item,spacing: CGFloat = 30, cardPadding: CGFloat = 80, id: KeyPath<Item.Element, ID>,@ViewBuilder content: @escaping(Item.Element,CGSize)->Content) {
        self.content = content
        self.id = id
        self._index = index
        self.spacing = spacing
        self.cardPadding = cardPadding
        self.items = items
    }
    //Gesture properties
    @GestureState var translation: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    @State var currentIndex: Int = 0
    //MARK: Rotation
    @State var rotation: Double = 0
    var body: some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            //MARK: Reduced after applying card spacing and padding
            let cardWidth = size.width - (cardPadding - spacing)
            LazyHStack(spacing: spacing){
                ForEach(items,id: id){milkShake in
                    //since e already applying spacing
                    // and again we are adding it to frame
                    // so simply removing the spacing
                    let index = indexOf(item: milkShake)
                    content(milkShake,CGSize(width: size.width - cardPadding, height: size.height))
                    //MARK: Rotating each view 5 Deg Multiplied with it's Index
                    // And while scrolling setting it to 0, thus it will give some nice circular carousel effect
                        .rotationEffect(.init(degrees: Double(index) * 5), anchor:.bottom)
                        .rotationEffect(.init(degrees: rotation), anchor: .bottom)
                    //Aply after rotation, thus you will get smootheffect
                        .offset(y: offsetY(index: index, cardWidth: cardWidth))
                        .frame(width: size.width - cardPadding, height: size.height)
                        .contentShape(Rectangle())
                }
            }
            .padding(.horizontal,spacing)
            .offset(x: limitScroll())
            .contentShape(Rectangle())
           
            .gesture(
                DragGesture(minimumDistance: 5)
                    .updating($translation, body: { value, out, _ in
                        out = value.translation.width
                    })
                .onChanged{onChanged(value: $0, cardWidth: cardWidth)}
                    .onEnded{onEnd(value: $0, cardWidth: cardWidth)}
            )
        }
        .padding(.top,60)
        .onAppear{
            let extraSpace = (cardPadding / 2) - spacing
            offset = extraSpace
            lastStoredOffset = extraSpace
        }
        .animation(.easeInOut, value: translation == 0)
    }
    //MARK: Moving current item up
    func offsetY(index: Int,cardWidth: CGFloat)->CGFloat{
        //MARK: we were converting the current translation, not whole offset
        //Thats why created @genstureState to hold the current translation Data
        
        // converting translation to -60...60
        let progress = ((translation < 0 ? translation : -translation) / cardWidth) * 60
        let yOffset = -progress < 60 ? progress : -(progress + 120)
      
        //MARK: checking previous, next and in between offsets
        let previous = (index - 1) == self.index ? (translation < 0 ? yOffset : -yOffset) : 0
        let next = (index + 1) == self.index ? (translation < 0 ? -yOffset : yOffset) : 0
        let In_Between = (index - 1) == self.index ? previous : next
        
        return index == self.index ? -60 - yOffset : In_Between
        
    }
    //MARK: Item Index
    func indexOf(item: Item.Element)->Int{
        let array = Array(items)
        if let index = array.firstIndex(of: item){
            return index
        }
        return 0
    }
    //MARK: limiting scroll on first and last item
    func limitScroll()->CGFloat{
        let extraSpace = (cardPadding / 2) - spacing
        if index == 0 && offset > extraSpace {
            return translation / 4
        }else if index == items.count - 1 && translation < 0{
            return offset - (translation / 2)
        }else{
            return offset
        }
    }
    
    func onChanged(value: DragGesture.Value,cardWidth:CGFloat){
        let translationX = value.translation.width
        offset = translationX + lastStoredOffset
        
        //MARK: Calculation rotation
        let progress = offset / cardWidth
        rotation = progress * 5
        
    }
    func onEnd(value: DragGesture.Value, cardWidth:CGFloat){
       //MARK: finding current index
        
        var _index = (offset / cardWidth).rounded()
        _index = max(-CGFloat(items.count - 1), _index)
        _index = min(_index, 0)
        
        currentIndex = Int(_index)
        //MARK: Updating Index
            // note since we were moving on right side
        //so all data will be negative
        index = -currentIndex
        withAnimation(.easeInOut(duration: 0.2)){
            //MARK: Removing extra space
            // why /2 -> Because we need both sides need to be visible
            
            let extraSpace = (cardPadding / 2) - spacing
            offset = (cardWidth * _index) + extraSpace
            
            //MARK: Calculation rotation
            let progress = offset / cardWidth
            //since index satrt with zero
            
            rotation = (progress * 5).rounded() - 1
            print(rotation)
        }
     lastStoredOffset = offset
    }
}
struct CustomCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
