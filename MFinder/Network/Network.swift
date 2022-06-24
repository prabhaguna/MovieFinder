//
//  Network.swift
//  MFinder
//
//  Created by Saadhurya on 22/06/22.
//

import Foundation
import UIKit

//http://www.omdbapi.com/?apikey=b9bd48a6&s=Marvel&type=movie

let API_URL = "http://www.omdbapi.com/"
let API_KEY = "b9bd48a6"

typealias ImageComletion = ((UIImage) -> ())?
typealias ResponseBlock = ((Decodable?, Error?) -> ())?

protocol Network {
    func fetch(url : String, completion : ResponseBlock)
}

extension Network {
    static func baseUrl() -> String {
        return "\(API_URL)?apikey=\(API_KEY)"
    }
}


