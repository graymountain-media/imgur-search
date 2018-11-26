//
//  ImagePost.swift
//  ImgurSearch
//
//  Created by Jake Gray on 11/21/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: String
    let title: String
    let images: [Image]?
    let link: String?
    let isAlbum: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case images
        case link
        case isAlbum = "is_album"
    }
}
