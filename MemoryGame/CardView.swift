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
        Pie(endAngle:.degrees(240))
            .opacity(0.3)
            .overlay (
                Text(card.content)
                    .font(.system(size:200))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1,contentMode: .fit)
                    .padding(8)
            )
            .padding(7)
            .cardify(isFaceUp: card.isFaceUp)
        .opacity(card.isFaceUp || !card.isMatched ? 1:0)
       
            
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
