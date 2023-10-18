//
//  GIATrendingGIFsViewModel.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 10/10/2023.
//

import Foundation

class GIATrendingGIFsViewModel: ObservableObject {
    @Published var showingSearchGIFView = false
    @Published var isLoading = false
    @Published var trendingGifsList: [GIAGIFDetail] = []
    @Published var errorMessage = ""
    
    init() {
        /// call for trending gifs API
        fetchTrendingGIFs()
    }
    
    let trendingGifParameters: [String: Any] = [
        "api_key": "sX9lDEVuAg6AmqVxBEYtLgO0SlPmLM2I",
        "limit": 15,
        "offset": 0,
        "rating": "g",
        "bundle": "messaging_non_clips"
    ]
    
    func fetchTrendingGIFs() {
        isLoading = true
        NetworkManager.shared.request("https://api.giphy.com/v1/gifs/trending", method: .get, parameters: trendingGifParameters) { (result: Result<GIAGIFList, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let fetchedTrendingGifs):
                    self.trendingGifsList = fetchedTrendingGifs.data
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
