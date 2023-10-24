//
//  GIAGIFList.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 17/10/2023.
//

import SwiftUI

struct GIAGIFList: Decodable {
    let data: [GIAGIFDetail]
    let pagination: GIFPagination
}

struct GIFPagination: Decodable {
    let total_count: Int
    let count: Int
    let offset: Int
}
