//
//  GIAGIFDetail.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 17/10/2023.
//

import Foundation

struct GIAGIFDetail: Decodable {
    let type: String
    let id: String
    let url: String
    let images: GIAImages
}

struct GIAImages: Decodable {
    let original: GIAImageDetail
    let fixed_height: GIAImageDetail
}

struct GIAImageDetail: Decodable {
    let height: String
    let url: String
}
