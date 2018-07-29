//
//  DataRequest+Helpers.swift
//  Chatroom
//
//  Created by ChangLink on 2016/12/22.
//  Copyright © 2016年 Nogle. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension DataRequest {
    static func apiResponseSerializer() -> DataResponseSerializer<JSON> {
        return DataResponseSerializer { _, response, data, error in
            
            if let err = error { return .failure(err) }
            
            guard let responseData = data else {
                let reason = "Data could not be serialized. Input data was nil."
                return .failure(NSError(domain: "org.link.moviedb", code: 1001, userInfo: [NSLocalizedDescriptionKey: reason]))
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                return sanitizeError(JSON(result))
            } catch let error as NSError {
                return .failure(error)
            }
        }
    }
    
    static func sanitizeError(_ json: JSON) -> Result<JSON> {
        if json["status_code"].intValue > 0 {
            let error = NSError(domain: "org.link.moviedb", code: json["status_code"].intValue, userInfo: [NSLocalizedDescriptionKey: json["status_message"].stringValue])
            return .failure(error)
        }
        
        return .success(json)
        
    }
    
    @discardableResult func apiResponseJSON(completionHandler: @escaping (DataResponse<JSON>) -> Void) -> Self {
        return response(responseSerializer: DataRequest.apiResponseSerializer(), completionHandler: completionHandler)
    }
}
