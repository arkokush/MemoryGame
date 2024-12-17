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
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding()
        .foregroundColor(.orange)
        
    }
}
struct CardView: View{
    @State var isFaceUp = false
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)
            if(isFaceUp){
                base
                    .foregroundColor(.white)
                base
                    .strokeBorder(lineWidth: 4)
                Text("😎").font(.largeTitle)}
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
