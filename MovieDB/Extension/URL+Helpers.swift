//
//  URL+Helpers.swift
//  Chatroom
//
//  Created by ChangLink on 2016/12/22.
//  Copyright © 2016年 Nogle. All rights reserved.
//

import Foundation
extension URL {
    
    static var baseURL:URL? = nil
    
    static func getBaseURL() -> URL {
 
        if baseURL != nil { return baseURL! }
        
        return URL(string: ApiServerBaseAddress)!
        
    }
    
    func URLByAppendingEndpoint(_ endpoint: Endpoint) -> URL {
        return appendingPathComponent(endpoint.path)
    }
    
    static func resetBaseURL(){
        baseURL = nil
    }
    
    static func getListPhotoURL(_ path: String) -> URL {
        return URL(string: PhotoBaseAddress + ListPhotoPath + path)!
    }
    static func getDetailPhotoURL(_ path: String) -> URL {
        return URL(string: PhotoBaseAddress + DetailPhotoPath + path)!
    }
}
