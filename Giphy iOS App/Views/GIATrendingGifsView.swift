//
//  TrendingGifsView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI

struct GIATrendingGifsView: View {
    @State private var searchText: String = ""
    @StateObject var viewModel: GIATrendingGIFsViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: GIATrendingGIFsViewModel())
    }
    
    var body: some View {
        NavigationView {
            List(0..<10, id: \.self) { index in
                GIAListItemView(gifURL: URL(string: "https://media.giphy.com/media/jHXYSO115NBLLyc9wY/giphy.gif")!)
                    .frame(height: 200)
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Trending GIFs")
            .toolbar {
                Button {
                    // Show Search Gifs Sheet
                    viewModel.showingSearchGIFView = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .tint(.secondary).font(.system(size: 18))
                }
            }.sheet(isPresented: $viewModel.showingSearchGIFView) {
                GIASearchGIFView(
                    text: "",
                    searchGIFViewPresented: $viewModel.showingSearchGIFView
                )
            }
        }
    }
}

struct TrendingGifs_Previews: PreviewProvider {
    static var previews: some View {
        GIATrendingGifsView()
    }
}
