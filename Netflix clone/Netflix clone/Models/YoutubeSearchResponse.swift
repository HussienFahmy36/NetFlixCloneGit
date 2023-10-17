//
//  YoutubeSearchResponse.swift
//  Netflix clone
//
//  Created by Hussien Gamal Mohammed on 16/10/2023.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
