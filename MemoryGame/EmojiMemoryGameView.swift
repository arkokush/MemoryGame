//
//  ContentView.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/13/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio:CGFloat = 2/3

    var body: some View {
        VStack{
            Text("Points: \(viewModel.points)")
                .fontDesign(.serif)
                .font(.title2)
                cards
                    .animation(.default, value: viewModel.cards)
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
    

    private var cards: some View{
         GeometryReader{ geometry in
            let gridItemSize = gridItemWidthThatFits(
            count: viewModel.cards.count,
             size: geometry.size,
             aspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0 ) {
                ForEach(viewModel.cards ){ card in
                    CardView(card)
                        .aspectRatio(aspectRatio,contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(viewModel.getThemeColor())
        
    }
   private  func gridItemWidthThatFits (
    count: Int,
    size: CGSize,
    aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat{
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount*height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount+=1
            
        }while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
                   
   }
}
private struct CardView: View{
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
