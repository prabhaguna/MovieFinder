//
//  MovieRequest.swift
//  MFinder
//
//  Created by Saadhurya on 22/06/22.
//

import Foundation

struct MovieRequest : APIRequestModel {
 
    typealias Response = MovieResponse
    var s : String?
    var type : String?
    var page : Int = 0
    
    func getUrl() -> String {
        var url = "&s=\(self.s ?? "")&type=\(self.type ?? "")"
        if page > 0 {
            url +=  "&page=\(page)"
        }
        return url
    }
}

extension MovieRequest {
    
    init(s : String?, page : Int = 0) {
        self.s = s
        self.type = "movie"
        self.page = page
    } 
   
}
