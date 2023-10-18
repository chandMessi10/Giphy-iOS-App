//
//  SearchBarView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 10/10/2023.
//

import SwiftUI
import RealmSwift
import SimpleToast

struct GIASearchGIFView: View {
    @State var text: String
    @State var showToast: Bool = false
    @State var isGIFLiked: Bool = false
    
    @ObservedResults(GIAFavouriteGIF.self) var favGifsList
    
    @StateObject var viewModel: GIASearchViewViewModel
    @Environment(\.dismiss) private var dismiss
    
    init() {
        self._viewModel = StateObject(wrappedValue: GIASearchViewViewModel())
        self._text = State(initialValue: "")
    }
    
    private let toastOptions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 2,
        modifierType: .skew
    )
    
    var body: some View {
        VStack(alignment: .center) {
            /// Title and sheet close button
            HStack {
                Text("Explore New GIFs 😀")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                Button(action: {
                    /// Close the sheet
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .imageScale(.large)
                }
            }.padding(.all, 20)
            /// Search field
            ZStack(alignment: .trailing) {
                TextField("Search gifs...", text: $text)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray4))
                    .cornerRadius(8)
                    .onChange(of: text, initial: false) {
                        if (!text.isEmpty) {
                            viewModel.fetchSearchedGIFs(queryValue: text)
                        }
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        // Action for the suffix button
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 10)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            Spacer()
            if (!text.isEmpty) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                } else {
                    ScrollView {
                        ForEach(viewModel.searchGifsList, id: \.id) { searchedGif in
                            GIAGIFView(
                                gifIDValue: searchedGif.id,
                                gifURL: URL(string: searchedGif.images.original.url)!,
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
                    .padding(.leading)
                    .padding(.trailing)
                }
            }
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
    }
}

struct GIASearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        GIASearchGIFView()
    }
}
