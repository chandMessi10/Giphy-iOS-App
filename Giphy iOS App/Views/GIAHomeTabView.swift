//
//  ContentView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI

struct GIAHomeTabView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        // If monitor detects valid network connection
        if networkMonitor.isConnected {
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
        } else {
            // Otherwise, show network error
            GIANoNetworkView()
        }
    }
}

#Preview {
    GIAHomeTabView()
}
