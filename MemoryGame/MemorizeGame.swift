//
//  MemorizeGame.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/20/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards: [Card]
    private(set) var points = 0
    
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
        set{ cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)}}
    }
    
    //MARK: -Intents
    mutating func chooseCard(_ card: Card){
        if let chosenIndex = cards.firstIndex(of: card){
            if(!cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched){
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true;
                        cards[potentialMatchIndex].isMatched = true
                        points+=2 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
                    }
                    else if cards[chosenIndex].isFlippedBefore && cards[potentialMatchIndex].isFlippedBefore{
                        points-=2
                    }
                    else if cards[chosenIndex].isFlippedBefore || cards[potentialMatchIndex].isFlippedBefore{
                        points-=1
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
        
        var isFaceUp = false {
            didSet{
                if isFaceUp {
                    startUsingBonusTime()
                }
                else {
                    stopUsingBonusTime()
                }
                if oldValue && !isFaceUp {
                    isFlippedBefore = true
                }
                
            }
        }
        var isFlippedBefore = false
        var isMatched = false {
            didSet{
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        let content: CardContent
        
        var id: String
        var debugDescription:String { "\(id): \(content), \(isFaceUp ? "face up" : "face down"), \(isMatched ? "matched" : "")"
        }
        // MARK: - Bonus Time
        
        // call this when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        // this gets smaller and smaller the longer the card remains face up without being matched
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        // percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        // how long this card has ever been face up and unmatched during its lifetime
        // basically, pastFaceUpTime + time since lastFaceUpDate
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // can be zero which would mean "no bonus available" for matching this card quickly
        var bonusTimeLimit: TimeInterval = 6
        
        // the last time this card was turned face up
        var lastFaceUpDate: Date?
        
        // the accumulated time this card was face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
    }

    
    
    struct Theme{
        let name: String
        let content:[CardContent]
        let numberOfPairs: Int
        let color: String
    }
}

extension Array{
    var only: Element? {
        return count == 1 ? first : nil
    }
}
