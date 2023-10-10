//
//  FavouriteGifsView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI

struct FavouriteGifsView: View {
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<10) { index in
                        GridItemView(gifURL: URL(string: "https://media.giphy.com/media/jHXYSO115NBLLyc9wY/giphy.gif")!)
                            .frame(height: 180)
                    }
                }
                .padding(16)
            }.navigationTitle("Favourite GIFs")
        }
    }
}

struct FavouriteGifs_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteGifsView()
    }
}
