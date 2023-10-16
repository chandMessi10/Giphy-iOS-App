//
//  GIAFavouriteGIF.swift
//  Giphy iOS App
//
//  Created by Suraj Chand on 16/10/2023.
//

import Foundation
import RealmSwift

class GIAFavouriteGIF: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var gifURL: String
    @Persisted var gifIDValue: String
    
    override class func primaryKey() -> String? {
        "id"
    }
}
