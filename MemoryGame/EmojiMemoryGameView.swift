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
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio ){ card in
                    CardView(card)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                        .foregroundColor(viewModel.getThemeColor())
                }
            }
        
        
}
    
  


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
