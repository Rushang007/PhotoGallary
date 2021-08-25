//
//  Gallary_Model.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 24/08/21.
//

import Foundation

struct ResponseData: Codable {
    let errorMessage: String
    let gallary: [Gallary]
    

    enum CodingKeys: String, CodingKey {
        case gallary = "data"
        case errorMessage
    }
}

// MARK: - Datum
struct Gallary: Codable,Hashable {
    let name, image: String
    var isselected:Bool? = nil
}
