//
//  SearchBarView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 10/10/2023.
//

import SwiftUI

struct GIASearchGIFView: View {
    @State var text: String
    @Binding var searchGIFViewPresented: Bool
    
    var body: some View {
        VStack {
            /// Title and sheet close button
            HStack {
                Text("Explore New GIFs 😀")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                Button(action: {
                    /// Close the sheet
                    searchGIFViewPresented = false
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
                
                if !text.isEmpty {
                    Button(action: {
                        // Action for the suffix button
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct GIASearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        GIASearchGIFView(
            text:
                "",
            searchGIFViewPresented:
                Binding(
                    get: {
                        return true
                    },
                    set: {_ in}
                )
        )
    }
}
