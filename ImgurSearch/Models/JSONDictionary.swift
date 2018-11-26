//
//  JSONDictionary.swift
//  ImgurSearch
//
//  Created by Jake Gray on 11/21/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

struct JSONDictionary: Codable {
    let posts: [Post]
    
    enum CodingKeys: String, CodingKey {
        case posts = "data"
    }
}
