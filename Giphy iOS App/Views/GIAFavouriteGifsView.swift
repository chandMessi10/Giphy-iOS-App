//
//  FavouriteGifsView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI
import RealmSwift
import SimpleToast

struct GIAFavouriteGifsView: View {
    @State var showToast: Bool = false
    @State var isGIFLiked: Bool = false
    
    @ObservedResults(GIAFavouriteGIF.self) var favouriteGifs
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private let toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 2,
        modifierType: .skew
    )
    
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
                                    onAction: { likeValue in
                                        isGIFLiked = likeValue
                                        withAnimation {
                                            showToast.toggle()
                                        }
                                    }
                                )
                                .frame(height: 180)
                            }
                        }
                        .padding(16)
                    }
                }
            }
            .navigationTitle("Favourite GIFs")
            .simpleToast(isPresented: $showToast, options: toastOptions) {
                Label(
                    isGIFLiked ? "GIF favourited" : "GIF unfavourited",
                    systemImage: isGIFLiked ? "heart.fill" : "heart"
                ).padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct FavouriteGifs_Previews: PreviewProvider {
    static var previews: some View {
        GIAFavouriteGifsView()
    }
}
