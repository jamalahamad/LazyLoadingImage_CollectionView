//
//  DataModel.swift
//  LazyLoadingImage
//
//  Created by Jamal Ahamad on 18/04/24.
//

import Foundation

struct DataModel: Codable {
    var id: String
    var title: String
    var language: String
    var thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    var id: String
    var version: Int
    var domain: String
    var basePath: String
    var key: String
    var qualities: [Int]
    var aspectRatio: Int
}
