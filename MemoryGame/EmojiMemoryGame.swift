//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/20/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    
    init() {
        let random = Int.random(in: 1...5)
        if random == 1{
            EmojiMemoryGame.theme = christmas
        } else if random == 2{
            EmojiMemoryGame.theme = halloween
        } else if random == 3{
            EmojiMemoryGame.theme = nature
        } else if random == 4{
            EmojiMemoryGame.theme = faces
        } else {
            EmojiMemoryGame.theme = streetSigns
        }
        model = EmojiMemoryGame.createMemoryGame()
        shuffle()
    }
    
    private let christmas: MemoryGame<String>.Theme = .init(name: "Christmas",
                                        content: ["🎅🏻", "🤶🏻","🎄","🎉","🎁","🎊","🍪","🥛","🦌","🛷","🕎","🧦","❄️","☃️","🧣"],
                                        numberOfPairs: 12,
                                        color: "red")
    
    private let halloween: MemoryGame<String>.Theme = .init(name: "Halloween",
                                        content: ["🎃", "👻","🧙🏻‍♀️","🕷️","💀","👹","🍭","🍬","😱","☠️"],
                                        numberOfPairs: 10,
                                        color: "orange")
    
    private let nature: MemoryGame<String>.Theme = .init(name: "Nature",
                                        content: ["🌈", "🍀","🐍","🌲","🍃","🌿","🌼","🐥","🐸","🐾","🌝","🌱","🐞"],
                                        numberOfPairs: 13,
                                        color: "green")
    
    private let streetSigns: MemoryGame<String>.Theme = .init(name: "Street Signs",
                                        content: ["🛑", "⚠️","🅿️","🚳","⛔️","🚸","🚯","🚷","🚦","Ⓜ️","🚭"],
                                        numberOfPairs: 9,
                                        color: "blue")
    
    private let faces: MemoryGame<String>.Theme = .init(name: "Faces",
                                        content: ["😎", "🤓","🧐","🥸","😳","😃","😇","🥰","🤩","🥳"],
                                        numberOfPairs: 10,
                                        color: "purple")
    
    private static var theme: MemoryGame<String>.Theme = .init(name: "Christmas",
                                                        content: ["🎅🏻", "🤶🏻","🎄","🎉","🎁","🎊","🍪","🥛","🦌","🛷","🕎","🧦","❄️","☃️","🧣"],
                                                        numberOfPairs: 12,
                                                        color: "red")
    
    
    
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.content.indices.contains(pairIndex){
                return theme.content[pairIndex]
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
    
    func getThemeColor() -> Color{
        switch EmojiMemoryGame.theme.color{
            case "green": return Color.green
            case "blue": return Color.blue
            case "red": return Color.red
            case "orange": return Color.orange
            default: return Color.purple
            
        }
    }
    
    func changeTheme(){
        let random = Int.random(in: 1...5)
        if random == 1{
            EmojiMemoryGame.theme = christmas
        } else if random == 2{
            EmojiMemoryGame.theme = halloween
        } else if random == 3{
            EmojiMemoryGame.theme = nature
        } else if random == 4{
            EmojiMemoryGame.theme = faces
        } else {
            EmojiMemoryGame.theme = streetSigns
        }
        
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
    
    func newGame(){
        let random = Int.random(in: 1...5)
        if random == 1{
            EmojiMemoryGame.theme = christmas
        } else if random == 2{
            EmojiMemoryGame.theme = halloween
        } else if random == 3{
            EmojiMemoryGame.theme = nature
        } else if random == 4{
            EmojiMemoryGame.theme = faces
        } else {
            EmojiMemoryGame.theme = streetSigns
        }
        model = EmojiMemoryGame.createMemoryGame()
        shuffle()
    }
                                                                  
}
