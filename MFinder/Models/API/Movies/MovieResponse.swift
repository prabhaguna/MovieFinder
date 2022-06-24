//
//  MovieResponse.swift
//  MFinder
//
//  Created by Saadhurya on 22/06/22.
//

import Foundation

struct MovieResponse : Decodable {
    var Search : [Movie]?
    var totalResults : String?
    var Response : String?
}
