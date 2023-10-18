//
//  NetworkManager.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 10/10/2023.
//

import Alamofire
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let headers: HTTPHeaders = [
        "Accept": "application/json"
    ]
    
    func request<T: Decodable>(
        _ urlEnpoint: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            urlEnpoint,
            method: method,
            parameters: parameters,
            encoding: URLEncoding.queryString,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
