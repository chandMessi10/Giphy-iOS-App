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
    @Published var isFetchingNextPage = false // Add a new loading state
    
    var offset = 0 // Initial offset value
    let limit = 15 // Number of items per page
    var totalGIFsCount = 0
    
    init() {
        /// call for trending gifs API
        fetchTrendingGIFs(isLoadingMore: false)
    }
    
    func fetchTrendingGIFs(isLoadingMore: Bool) {
//        isLoading = true
        if (!isLoadingMore) {
            isLoading = true
        } 
        else {
            isFetchingNextPage = true
        }
        let trendingGifParameters: [String: Any] = [
            "api_key": "sX9lDEVuAg6AmqVxBEYtLgO0SlPmLM2I",
            "limit": limit,
            "offset": offset,
            "rating": "g",
            "bundle": "messaging_non_clips"
        ]
        
        NetworkManager.shared.request("https://api.giphy.com/v1/gifs/trending", method: .get, parameters: trendingGifParameters) { (result: Result<GIAGIFList, Error>) in
            DispatchQueue.main.async {
//                self.isLoading = false
                if (!isLoadingMore) {
                    self.isLoading = false
                } 
                else {
                    self.isFetchingNextPage = false
                }
                switch result {
                case .success(let fetchedTrendingGifs):
                    self.trendingGifsList.append(contentsOf: fetchedTrendingGifs.data)
                    self.totalGIFsCount = fetchedTrendingGifs.pagination.total_count
                    // Update the offset for the next page
                    self.offset += self.limit
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func loadNextPage() {
        fetchTrendingGIFs(isLoadingMore: true)
    }
}
