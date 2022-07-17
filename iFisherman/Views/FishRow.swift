//
//  FishRow.swift
//  iFisherman
//
//  Created by Wuz Good on 08.07.2022.
//

import SwiftUI

struct FishRow: View {
    @State var fish: Fish
    
    var body: some View {
        HStack {
            loadImage(for: fish)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .shadow(radius: 3)
            
            VStack(alignment: .leading,spacing: 3) {
                Text(fish.name)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                Text(fish.weight.formattedKilograms())
                    .font(.system(size: 12))
                
                Spacer()
                Text(fish.date.formatted())
                    .font(.system(size: 10))
            }
        }
        .padding(.vertical, 5)
    }
}

extension View {
    
}

