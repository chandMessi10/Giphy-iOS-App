//
//  TrendingGifsView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 09/10/2023.
//

import SwiftUI
import RealmSwift
import SimpleToast
import SwiftUIInfiniteList

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
                        List {
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
                                .listRowSeparator(.hidden)
                            }
                            .listStyle(PlainListStyle())
                            
                            if viewModel.offset < viewModel.totalGIFsCount {
                                if !viewModel.isLoading {
                                    ProgressView().frame(maxWidth: .infinity).padding().onAppear {
    //                                        viewModel.loadNextPage()
                                        }
                                        .listRowSeparator(.hidden)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
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
            }
            .refreshable {
                viewModel.offset = 0
                viewModel.fetchTrendingGIFs(isLoadingMore: false)
            }
            .simpleToast(isPresented: $showToast, options: toastOptions) {
                Label(
                    isGIFLiked ? "GIF favourited" : "GIF unfavourited",
                    systemImage: isGIFLiked ? "heart.fill" : "heart"
                ).padding()
                    .background(Color.white)
                    .foregroundColor(Color.gray)
                    .cornerRadius(10)
                    .padding(.top)
            }
//            .padding(.leading)
//            .padding(.trailing)
        }
    }
    
    func loadMoreData() {
        
    }
}

struct TrendingGifs_Previews: PreviewProvider {
    static var previews: some View {
        GIATrendingGifsView()
    }
}
