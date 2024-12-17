//
//  ContentView.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/13/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["😎", "🤓","🧐","🥸","🥸"]

    var body: some View {
        HStack {
            ForEach(emojis.indices,id: \.self){index in
                CardView(content:emojis[index])

            }
          
        }
        .padding()
        .foregroundColor(.orange)
        
    }
}
struct CardView: View{
    let content: String
    @State var isFaceUp = false
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)
            if(isFaceUp){
                base
                    .foregroundColor(.white)
                base
                    .strokeBorder(lineWidth: 4)
                Text(content).font(.largeTitle)}
            else{
                base
            }
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
            
    }
}
#Preview {
    ContentView()
}
