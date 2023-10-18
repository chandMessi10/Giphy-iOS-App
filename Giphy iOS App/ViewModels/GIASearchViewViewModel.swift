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
    @Published var searchQuery = ""
    @Published var errorMessage = ""
    
    func fetchSearchedGIFs(queryValue: String) {
        let searchGifParameters: [String: Any] = [
            "api_key": "sX9lDEVuAg6AmqVxBEYtLgO0SlPmLM2I",
            "q": queryValue,
            "limit": 15,
            "offset": 0,
            "rating": "g",
            "lang": "en",
            "bundle": "messaging_non_clips"
        ]
        
        isLoading = true
        NetworkManager.shared.request("https://api.giphy.com/v1/gifs/search", method: .get, parameters: searchGifParameters) { (result: Result<GIAGIFList, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let fetchedTrendingGifs):
                    print("searched gifs")
                    self.searchGifsList = fetchedTrendingGifs.data
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
