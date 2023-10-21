//
//  GIANoNetworkView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 21/10/2023.
//

import SwiftUI

struct GIANoNetworkView: View {
    var showButton : Bool = false
    var body: some View {
        ContentUnavailableView(
            label: {
                Label("No Internect Connection", systemImage: "bell")
            },
            description: {
                Text("There seems to be network issue. Please check your internet connection.")
            },
            actions: {
                if (showButton) {
                    Button("Retry") {
                        // retry function
                    }
                }
            }
        )
    }
}

#Preview {
    GIANoNetworkView()
}
