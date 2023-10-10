//
//  GridItemView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 10/10/2023.
//

import SwiftUI
import Giffy

struct GridItemView: View {
    let gifURL: URL // URL of the GIF image
    
    @State private var isLiked = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncGiffy(url: gifURL) { phase in
                switch phase {
                case .loading:
                    ProgressView()
                case .error:
                    Text("Failed to load GIF")
                case .success(let giffy):
                    giffy
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button(action: {
                isLiked.toggle() // Toggle the liked state when the button is tapped
            }) {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: isLiked ? "heart.fill" : "heart") // Heart icon
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                }
                .padding(8) // Adjust the padding as needed
                .offset(x: -2, y: 2) // Adjust the offset to position the heart icon as needed
            }
        }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        GridItemView(gifURL: URL(string: "https://media.giphy.com/media/jHXYSO115NBLLyc9wY/giphy.gif")!)
    }
}
