//
//  Movie.swift
//  Netflix clone
//
//  Created by Hussien Gamal Mohammed on 12/10/2023.
//

import Foundation

struct TrendingTitleResponse: Decodable {
    let results: [Title]
}

struct Title: Decodable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
