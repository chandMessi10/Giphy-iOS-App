//
//  FavouriteGifsView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI
import RealmSwift

struct GIAFavouriteGifsView: View {
    
    @ObservedResults(GIAFavouriteGIF.self) var favouriteGifs
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if (favouriteGifs.isEmpty) {
                    LottieView(loopMode: .loop)
                        .scaleEffect(0.4)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(favouriteGifs) { favGif in
                                GIAGIFView(
                                    gifIDValue: favGif.gifIDValue,
                                    gifURL: URL(string: favGif.gifURL)!,
                                    isLiked: true
                                )
                                .frame(height: 180)
                            }
                        }
                        .padding(16)
                    }
                }
            }.navigationTitle("Favourite GIFs")
        }
    }
}

struct FavouriteGifs_Previews: PreviewProvider {
    static var previews: some View {
        GIAFavouriteGifsView()
    }
}
