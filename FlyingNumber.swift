//
//  FlyingNumber.swift
//  MemoryGame
//
//  Created by Arkady Kokush on 2/4/25.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    @State private var offset: CGFloat = 0
    
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .fontDesign(.serif)
                .font(.largeTitle)
                .foregroundColor(number > 0 ? .green : .red)
                .shadow(color: .black, radius: 1.5, x:1 , y:1)
                .opacity(offset == 0 ? 1 : 0)
                .onAppear() {
                    withAnimation(.linear(duration: 3)) {
                        offset = number < 0 ? 200 : -200
                    }
                }
                .onDisappear(){offset = 0}
                .offset(y: offset)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
