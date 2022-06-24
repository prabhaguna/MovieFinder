//
//  ApiCall.swift
//  MFinder
//
//  Created by Saadhurya on 22/06/22.
//

import Foundation
import Alamofire


class ApiHandler<Request : APIRequestModel> : Network {

    func fetch(url : String, completion : ResponseBlock) {
        
        if let url = URL(string: ApiHandler.baseUrl() +  url) {
            AF.request(url).responseDecodable(of: Request.Response.self) { response in
                completion?(response.value, nil)
            }
        }
    }
}
