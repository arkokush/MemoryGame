//
//  ContentView.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/13/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio:CGFloat = 2/3
    
    
    var body: some View {
        VStack{
            pointBoard
            cards
            menuBar
        }
        .padding()
    }
    
    private var pointBoard: some View {
        Text("Points: \(viewModel.points)")
            .fontDesign(.serif)
            .font(.title2)
            .animation(nil)
    }
    
    private var menuBar: some View {
        HStack{
            newGameButtonn
            Spacer()
            shuffleButton
        }
    }
    
    private var newGameButtonn: some View {
        Button("New Game"){
            viewModel.newGame()
        }
    }
    
    private var shuffleButton: some View {
        Button("Shuffle"){
            withAnimation{
                viewModel.shuffle()
            }
        }
    }
    private var cards: some View{
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio ){ card in
            if isDealt(card){
                CardView(card)
                    .padding(4)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    .foregroundColor(viewModel.getThemeColor())
            }
        }
        .onAppear(){
            //Deal the cards
            withAnimation(.easeInOut(duration: 2)){
                for card in viewModel.cards{
                    dealt.insert(card.id)
                }
                        
            }
        }
        
    }
        
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    private var undealtCards : [Card]{
        viewModel.cards.filter{!isDealt($0)}
    }
    
    private var deck : some View {
        ZStack{
            ForEach(undealtCards) {card in
                CardView(card)
            }
        }
    }
    
    private func choose(_ card:Card){
        withAnimation{
            let scoreBeforeChoosing = viewModel.points
            viewModel.choose(card)
            let scoreChange = viewModel.points - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardID: card.id)
        }
    }
    @State private var lastScoreChange = (0, causedByCardID: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}
    
  


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
