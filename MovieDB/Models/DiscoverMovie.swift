//
//  DiscoverMovie.swift
//  MovieDB
//
//  Created by Mac on 2018/7/28.
//  Copyright © 2018年 Link. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DiscoverMovie {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    var movies: Array<MovieOverview>
    
}
extension DiscoverMovie {
    init(_ json: JSON) {
        page = json["page"].intValue
        totalResults = json["total_results"].intValue
        totalPages = json["total_pages"].intValue
        movies = json["results"].arrayValue.map { MovieOverview($0) }

    }
}
