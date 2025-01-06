//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/20/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    private static var theme: MemoryGame<String>.Theme  =
        .init(name: "Winter",
              content: ["🎅🏻", "🤶🏻","🎄","🎉","🎁","🎊","🍪","🥛","🦌","🛷","🕎","🧦","❄️","☃️","🧣"],
              numberOfPairs: 10,
              color: .green)
    private static var emojis = theme.content
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "‼"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    
    var cards : [MemoryGame<String>.Card] { model.cards }
    
    
    //MARK: - Intents
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
    
    func newGame(){
        model = EmojiMemoryGame.createMemoryGame()
    }
                                                                  
}
