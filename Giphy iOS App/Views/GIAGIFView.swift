//
//  GridItemView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 10/10/2023.
//

import SwiftUI
import Giffy
import RealmSwift

struct GIAGIFView: View {
    let gifIDValue: String
    let gifURL: URL // URL of the GIF image
    var isLiked: Bool
    
    @ObservedResults(GIAFavouriteGIF.self) var favouriteGifs
    @Environment(\.realm) private var realm
    
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
                if favouriteGifs.contains(where: { $0.gifIDValue == gifIDValue }) {
                    // Remove from favgif db
                    let gifToDelete = realm.objects(GIAFavouriteGIF.self).where {
                        $0.gifIDValue == gifIDValue
                    }
                    do {
                        try realm.write {
                            realm.delete(gifToDelete)
                        }
                    } catch {
                        print("Error deleting item: \(error)")
                    }
                } else {
                    // Add to favgif db
                    let newFavGIF = GIAFavouriteGIF()
                    newFavGIF.gifIDValue = gifIDValue
                    newFavGIF.gifURL = gifURL.absoluteString
                    do {
                        try realm.write {
                            realm.add(newFavGIF)
                        }
                    } catch {
                        print("Error adding item: \(error)")
                    }
                }
            }) {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                    
                    Image(
                        systemName: favouriteGifs.contains(where: { $0.gifIDValue == gifIDValue }) ? "heart.fill" : "heart") // Heart icon
                    .foregroundColor(.red)
                    .font(.system(size: 20)
                    )
                }
                .padding(8) // Adjust the padding as needed
                .offset(x: -2, y: 2) // Adjust the offset to position the heart icon as needed
            }
        }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        GIAGIFView(
            gifIDValue: "0",
            gifURL: URL(string: "https://media.giphy.com/media/jHXYSO115NBLLyc9wY/giphy.gif")!,
            isLiked: true
        )
    }
}
