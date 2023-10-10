//
//  ContentView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI

struct GIAHomeTabView: View {
    var body: some View {
        TabView {
            GIATrendingGifsView()
                .tabItem {
                    Label("Trending", systemImage: "flame.fill")
                }
            GIAFavouriteGifsView()
                .tabItem {
                    Label("Favourite", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    GIAHomeTabView()
}
