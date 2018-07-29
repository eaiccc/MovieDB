//
//  genres.swift
//  MovieDB
//
//  Created by Mac on 2018/7/28.
//  Copyright © 2018年 Link. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Genres {
    var genresId: Int
    var name: String
}
extension Genres {
    init(_ json: JSON) {
        genresId = json["id"].intValue
        name = json["name"].stringValue
    }
}

