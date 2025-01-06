//
//  MemorizeGame.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/20/24.
//

import Foundation
import SwiftUICore

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        //add pairs*2 cards
        for pairIndex in 0..<max(2,numberOfPairsOfCards){
            let content = cardContentFactory(pairIndex)
            cards.append(Card( content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{ cards.indices.filter { cards[$0].isFaceUp }.only}
        set{ cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}}
    }
    
    //MARK: -Intents
    mutating func chooseCard(_ card: Card){
        if let chosenIndex = cards.firstIndex(of: card){
            if(!cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched){
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true;
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else{
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
               cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    
    //MARK: -Structs
    struct Card: Equatable, Identifiable,  CustomDebugStringConvertible{
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription:String { "\(id): \(content), \(isFaceUp ? "face up" : "face down"), \(isMatched ? "matched" : "")"
        }
        
    }
    
    struct Theme{
        let name: String
        let content:[CardContent]
        let numberOfPairs: Int
        let color: Color
    }
}

extension Array{
    var only: Element? {
        return count == 1 ? first : nil
    }
}
