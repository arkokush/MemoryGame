//
//  CardView.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 1/16/25.
//

import SwiftUI

 struct CardView: View{
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
     var body: some View{
         TimelineView(.animation){_ in
             if card.isFaceUp || !card.isMatched {
                 Pie(endAngle:.degrees(card.bonusPercentRemaining*360))
                     .opacity(0.3)
                     .overlay (cardContents)
                     .padding(2)
                     .cardify(isFaceUp: card.isFaceUp)
                     .transition(.scale)
             }
             else {
                 Color.clear
             }
         }
     }
     var cardContents : some View {
         Text(card.content)
             .font(.system(size:200))
             .minimumScaleFactor(0.15)
             .multilineTextAlignment(.center)
             .aspectRatio(1,contentMode: .fit)
             .padding()
             .rotationEffect(.degrees(card.isMatched ? 360 : 0))
             .animation(.easeInOut(duration: 1), value: card.isMatched)
     }
}

#Preview {
    VStack{
        HStack{
            CardView(MemoryGame<String>.Card( isFaceUp: true, content: "X" , id: "test"))
            CardView(MemoryGame<String>.Card(  content: "X" , id: "test"))
            
        }
        HStack{
            CardView(MemoryGame<String>.Card(isFaceUp: true, isMatched: true,  content: "X" , id: "test"))
            CardView(MemoryGame<String>.Card(  isMatched: true,  content: "X" , id: "test"))
            
        }
    }
    .padding()
}
