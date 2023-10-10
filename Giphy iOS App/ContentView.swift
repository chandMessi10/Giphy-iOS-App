//
//  ContentView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TrendingGifsView()
                .tabItem {
                    Label("Trending", systemImage: "flame.fill")
                }
            FavouriteGifsView()
                .tabItem {
                    Label("Favourite", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
