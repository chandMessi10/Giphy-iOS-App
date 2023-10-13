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
    @Published var users: [User] = []
    @Published var errorMessage = ""
    
    init() {
        /// call for trending gifs API
        fetchTrendingGIFs()
    }
    
    func fetchTrendingGIFs() {
        isLoading = true
        NetworkManager.shared.request("https://jsonplaceholder.typicode.com/users", method: .get) { (result: Result<[User], Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let fetchedUsers):
                    print("fetched users: \(fetchedUsers)")
                    self.users = fetchedUsers
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
