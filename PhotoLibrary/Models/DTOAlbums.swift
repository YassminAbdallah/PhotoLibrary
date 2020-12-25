//
//  DTOAlbums.swift
//  PhotoLibrary
//
//  Created by Yassmin Abdallah on 12/24/20.
//

import Foundation

struct DTOAlbums : Codable {
    let userId : Int?
    let id : Int?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case userId = "userId"
        case id = "id"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
