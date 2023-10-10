//
//  TrendingGifsView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI

struct TrendingGifsView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                Spacer()
                List(0..<10, id: \.self) { index in
                    GridItemView(gifURL: URL(string: "https://media.giphy.com/media/jHXYSO115NBLLyc9wY/giphy.gif")!)
                        .frame(height: 200)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Trending GIFs")
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search gifs...", text: $text)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color(.systemGray4))
                .cornerRadius(8).padding(.all)
            
            Button(action: {
                self.text = "" // Clear the search field
            }) {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.gray)
                    .imageScale(.large)
            }
            .padding(.trailing, 30)
        }
    }
}

struct TrendingGifs_Previews: PreviewProvider {
    static var previews: some View {
        TrendingGifsView()
    }
}
