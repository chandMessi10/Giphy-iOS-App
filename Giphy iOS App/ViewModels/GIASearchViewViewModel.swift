//
//  GIASearchViewViewModel.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 10/10/2023.
//

import Foundation

class GIASearchViewViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var searchGifsList: [GIAGIFDetail] = []
    @Published var errorMessage = ""
    
    @Published var isFetchingNextPage = false // Add a new loading state
    
    var offset = 0 // Initial offset value
    let limit = 15 // Number of items per page
    var totalGIFsCount = 0
    
    func clearVariables() {
        self.searchGifsList = []
        self.isFetchingNextPage = false
        self.offset = 0
        self.totalGIFsCount = 0
    }
    
    func fetchSearchedGIFs(queryValue: String, isLoadingMore: Bool) {
        if (!isLoadingMore) {
            isLoading = true
        } else {
            isFetchingNextPage = true
        }
        let searchGifParameters: [String: Any] = [
            "api_key": "sX9lDEVuAg6AmqVxBEYtLgO0SlPmLM2I",
            "q": queryValue,
            "limit": limit,
            "offset": offset,
            "rating": "g",
            "lang": "en",
            "bundle": "messaging_non_clips"
        ]
        
        NetworkManager.shared.request(
            "https://api.giphy.com/v1/gifs/search",
            method: .get,
            parameters: searchGifParameters
        ) { (result: Result<GIAGIFList, Error>) in
            DispatchQueue.main.async {
                if (!isLoadingMore) {
                    self.isLoading = false
                } else {
                    self.isFetchingNextPage = false
                }
                switch result {
                case .success(let fetchedTrendingGifs):
                    self.searchGifsList.append(contentsOf: fetchedTrendingGifs.data)
                    self.totalGIFsCount = fetchedTrendingGifs.pagination.total_count
                    // Update the offset for the next page
                    self.offset += self.limit
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func loadNextPage(queryValue: String) {
        fetchSearchedGIFs(queryValue: queryValue, isLoadingMore: true)
    }
}
