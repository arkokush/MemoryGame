//
//  ContentView.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/13/24.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = ["😎", "🤓","🧐","🥸","😳","🧐","🤓","🥸","😳","😎"]
    @State var color: Color = .red
     var cardCount = 10
    var body: some View {
        VStack{
            Text("Memorize!")
                .fontDesign(.serif)
                .font(.title2)
            ScrollView{
                cards
            }
            Spacer()
            emojiChangers
        }
        .padding()
    }
    
    func emojiChanger(theme:[String], colorSelected:Color, symbol: String) -> some View{
        Button(action: {
            emojis = theme
            color = colorSelected
            emojis.shuffle()
        }, label: {
            Text(symbol)
                .font(.largeTitle)
        })
    }
    
    var faces: some View{
        emojiChanger(theme: ["😎", "🤓","🧐","🥸","😳","🧐","🤓","🥸","😳","😎"] , colorSelected: .red,symbol:"😎" )
        
                             }
    var halloween: some View{
        emojiChanger(theme: ["🎃", "👻","🧙🏻‍♀️","🕷️","💀","🧙🏻‍♀️","👻","🕷️","💀","🎃"] ,colorSelected: .orange, symbol:"🎃" )
        
                             }
    var christmas: some View{
        emojiChanger(theme: ["🤶🏻", "🎄","🎁","🎉","🎅🏻","🎁","🎄","🎉","🎅🏻","🤶🏻"] ,colorSelected: .green, symbol:"🎄" )
        
                             }
    
   var emojiChangers: some View{
        HStack{
            faces
            Spacer()
            halloween
            Spacer()
            christmas
        }
        
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))] ) {
            ForEach(0..<cardCount,id: \.self){index in
                CardView(content:emojis[index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
            
        }
        .foregroundColor(color)
    }
   
}
struct CardView: View{
    let content: String
    @State var isFaceUp = false
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)
            Group{
                base
                    .foregroundColor(.white)
                base
                    .strokeBorder(lineWidth: 4)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1:0)
           
            base.opacity(isFaceUp ? 0:1)
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
            
    }
}
#Preview {
    ContentView()
}
