//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/20/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    
    
    
    init() {
        changeTheme()
        model = EmojiMemoryGame.createMemoryGame()
        shuffle()
    }
    
    private let themes: [MemoryGame<String>.Theme] = [christmas, halloween, nature, faces,   streetSigns, animals]
    
    private static let christmas: MemoryGame<String>.Theme = .init(name: "Christmas",
                                        content: ["🎅🏻", "🤶🏻","🎄","🎉","🎁","🎊","🍪","🥛","🦌","🛷","🕎","🧦","❄️","☃️","🧣"],
                                        numberOfPairs: 12,
                                        color: "red")
    
    private static let halloween: MemoryGame<String>.Theme = .init(name: "Halloween",
                                        content: ["🎃", "👻","🧙🏻‍♀️","🕷️","💀","👹","🍭","🍬","😱","☠️"],
                                        numberOfPairs: 8,
                                        color: "orange")
    
    private static let nature: MemoryGame<String>.Theme = .init(name: "Nature",
                                        content: ["🌈", "🍀","🐍","🌲","🍃","🌿","🌼","🐥","🐸","🐾","🌝","🌱","🐞"],
                                        numberOfPairs: 11,
                                        color: "green")
    
    private static let streetSigns: MemoryGame<String>.Theme = .init(name: "Street Signs",
                                        content: ["🛑", "⚠️","🅿️","🚳","⛔️","🚸","🚯","🚷","🚦","Ⓜ️","🚭"],
                                        numberOfPairs: 10,
                                        color: "blue")
    
    private static let faces: MemoryGame<String>.Theme = .init(name: "Faces",
                                        content: ["😎", "🤓","🧐","🥸","😳","😃","😇","🥰","🤩","🥳"],
                                        numberOfPairs: 7,
                                        color: "purple")
    
    private static let animals: MemoryGame<String>.Theme = .init(name: "Animals",
                                        content: ["🐈", "🐶","🦊","🐖","🫎","🐻","🐴","🐄","🐰","🐼","🐨","🦋","🐝","🐒","🧸"],
                                        numberOfPairs: 12,
                                        color: "pink")
    
    private static var theme: MemoryGame<String>.Theme = .init(name: "Christmas",
                                                        content: ["🎅🏻", "🤶🏻","🎄","🎉","🎁","🎊","🍪","🥛","🦌","🛷","🕎","🧦","❄️","☃️","🧣"],
                                                        numberOfPairs: 12,
                                                        color: "red")
    
    
    
    private static func createMemoryGame() -> MemoryGame<String>{
        var contentCopy = theme.content
        for _ in 0...contentCopy.indices.count-theme.numberOfPairs-1{
            contentCopy.remove(at: Int.random(in: contentCopy.indices))
        }
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) {
            pairIndex in
            if contentCopy.indices.contains(pairIndex){
                return contentCopy[pairIndex]
            } else {
                return "‼"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    
    var cards : [MemoryGame<String>.Card] { model.cards }
    var points : Int {model.points}
    
    
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
            case "yellow": return Color.yellow
            case "cyan": return Color.cyan
            case "purple": return Color.purple
            case "pink": return Color.pink
            default: return Color.purple
            
        }
    }
    
    func changeTheme(){
        if let newTheme = themes.randomElement(){
            EmojiMemoryGame.theme = newTheme
        }
        
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
    
    func newGame(){
        changeTheme()
        model = EmojiMemoryGame.createMemoryGame()
        shuffle()
    }
                                                                  
}
