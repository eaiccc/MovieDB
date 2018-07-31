//
//  SpokenLanguage.swift
//  MovieDB
//
//  Created by Mac on 2018/7/28.
//  Copyright © 2018年 Link. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SpokenLanguage {
    var iso6391: String
    var name: String
}
extension SpokenLanguage {
    init(_ json: JSON) {
        iso6391 = json["iso_639_1"].stringValue
        name = json["name"].stringValue
    }
    
}

