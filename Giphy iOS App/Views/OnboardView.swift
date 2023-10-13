//
//  OnboardView.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 12/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            OnboardView(systemImageName: "figure.run", title: "First Intro", description: "Great for health and sport")
            OnboardView(systemImageName: "figure.walk.motion", title: "Second Intro", description: "Great for health and sport")
            OnboardView(systemImageName: "figure.open.water.swim", title: "Third Intro", description: "Great for health and sport")
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardView: View {
    let systemImageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.teal)
            
            Text(title)
                .font(.title).bold()
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
