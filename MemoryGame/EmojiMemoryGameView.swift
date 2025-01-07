//
//  ContentView.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/13/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            Text("Points: \(viewModel.points)")
                .fontDesign(.serif)
                .font(.title2)
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            HStack{
                Button("New Game"){
                    viewModel.newGame()
                }
                Spacer()
                Button("Shuffle"){
                    viewModel.shuffle()
                }
            }
        }
        .padding()
    }
    

    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0 ) {
            ForEach(viewModel.cards ){ card in
                CardView(card)
                    .aspectRatio(2/3,contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            
        }
        .foregroundColor(viewModel.getThemeColor())
        
    }
   
}
struct CardView: View{
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)
            Group{
                base
                    .foregroundColor(.white)
                base
                    .strokeBorder(lineWidth: 4)
                Text(card.content)
                    .font(.system(size:200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1,contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1:0)
            base
                .fill()
                .opacity(card.isFaceUp ? 0:1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1:0)
       
            
    }
}
#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
