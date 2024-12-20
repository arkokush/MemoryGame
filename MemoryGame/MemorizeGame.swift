//
//  MemorizeGame.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/20/24.
//

import Foundation

struct MemoryGame<CardContent>{
    var cards: [Card]
    
    func chooseCard(card: Card){
        
    }
    
    struct Card{
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
