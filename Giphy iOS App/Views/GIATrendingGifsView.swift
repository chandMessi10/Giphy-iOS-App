//
//  TrendingGifsView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI
import RealmSwift
import SimpleToast

struct GIATrendingGifsView: View {
    @State private var searchText: String = ""
    @StateObject var viewModel: GIATrendingGIFsViewModel
    @State var showToast: Bool = false
    
    @ObservedResults(GIAFavouriteGIF.self) var favGifsList
    
    init() {
        self._viewModel = StateObject(wrappedValue: GIATrendingGIFsViewModel())
    }
    
    private let toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 5,
        modifierType: .skew
    )
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                }
                else {
                    List(0..<10, id: \.self) { index in
                        GIAGIFView(
                            gifIDValue: "69",
                            gifURL: URL(string: "https://media.giphy.com/media/jHXYSO115NBLLyc9wY/giphy.gif")!,
                            isLiked: false
                        )
                        .frame(height: 200)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Trending GIFs")
            .toolbar {
                Button {
                    // add to realmdb
                    let favGif = GIAFavouriteGIF()
                    favGif.gifIDValue = "69"
                    favGif.gifURL = "https://media.giphy.com/media/jHXYSO115NBLLyc9wY/giphy.gif"
                    $favGifsList.append(favGif)
                    // Show Search Gifs Sheet
//                    viewModel.showingSearchGIFView = true
//                    withAnimation {
//                        showToast.toggle()
//                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .tint(.secondary).font(.system(size: 18))
                }
            }.sheet(isPresented: $viewModel.showingSearchGIFView) {
                GIASearchGIFView(
                    text: "",
                    searchGIFViewPresented: $viewModel.showingSearchGIFView
                )
            }.refreshable {
                viewModel.fetchTrendingGIFs()
            }.simpleToast(isPresented: $showToast, options: toastOptions) {
                Label("GIF favourited", systemImage: "heart.fill")
                .padding()
                .background(Color.white)
                .foregroundColor(Color.gray)
                .cornerRadius(10)
                .padding(.top)
            }
        }
    }
}

struct TrendingGifs_Previews: PreviewProvider {
    static var previews: some View {
        GIATrendingGifsView()
    }
}
