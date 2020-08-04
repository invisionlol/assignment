// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dataResponse = try? newJSONDecoder().decode(DataResponse.self, from: jsonData)

import Foundation

// MARK: - DataResponse
struct DataResponse: Codable {
    let title: String
    let link: String
    let dataResponseDescription: String
    let generator: String
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case title, link
        case dataResponseDescription = "description"
        case generator, items
    }
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let media: Media
    let itemDescription: String
    let author, authorID, tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case itemDescription = "description"
        case author
        case authorID = "author_id"
        case tags
    }
}

// MARK: - Media
struct Media: Codable {
    let m: String
}
