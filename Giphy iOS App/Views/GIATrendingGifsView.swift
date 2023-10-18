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
    @StateObject var viewModel: GIATrendingGIFsViewModel
    @State var showToast: Bool = false
    @State var isGIFLiked: Bool = false
    
    @ObservedResults(GIAFavouriteGIF.self) var favGifsList
    
    init() {
        self._viewModel = StateObject(wrappedValue: GIATrendingGIFsViewModel())
    }
    
    private let toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 2,
        modifierType: .skew
    )
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                } else {
                    ScrollView {
                        ForEach(viewModel.trendingGifsList, id: \.id) { trendingGif in
                            GIAGIFView(
                                gifIDValue: trendingGif.id,
                                gifURL: URL(string: trendingGif.images.original.url)!,
                                onAction: { likeValue in
                                    isGIFLiked = likeValue
                                    withAnimation {
                                        showToast.toggle()
                                    }
                                }
                            )
                            .frame(height: 200)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
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
                GIASearchGIFView()
            }.refreshable {
                viewModel.fetchTrendingGIFs()
            }.simpleToast(isPresented: $showToast, options: toastOptions) {
                Label(
                    isGIFLiked ? "GIF favourited" : "GIF unfavourited",
                    systemImage: isGIFLiked ? "heart.fill" : "heart"
                ).padding()
                    .background(Color.white)
                    .foregroundColor(Color.gray)
                    .cornerRadius(10)
                    .padding(.top)
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
}

struct TrendingGifs_Previews: PreviewProvider {
    static var previews: some View {
        GIATrendingGifsView()
    }
}
