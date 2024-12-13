//
//  ContentView.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 12/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .padding()
        .foregroundColor(.orange)
        
    }
}
struct CardView: View{
    var isFaceUp:Bool = false
    var body: some View{
        ZStack (content: {
            if(isFaceUp){
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(lineWidth: 4)
                Text("😎").font(.largeTitle)}
            else{
                RoundedRectangle.init(cornerRadius: 30)
            }
            
        })
    }
}
#Preview {
    ContentView()
}
