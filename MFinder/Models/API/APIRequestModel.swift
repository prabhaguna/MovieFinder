//
//  APIModel.swift
//  MFinder
//
//  Created by Saadhurya on 22/06/22.
//

import Foundation

protocol APIRequestModel {
    associatedtype Response : Decodable
    typealias ResponseBlock = ((Response?, Error?) -> ())?
    func getUrl() -> String
}

extension APIRequestModel {
    
    func fetch(completion : ResponseBlock) {
        ApiHandler<Self>().fetch(url: getUrl(), completion: { response , error in
            
            if let response = response as? Self.Response {
                completion?(response, error)
            }
            
        })
    }
}


protocol APIResponseModel {
    
}
