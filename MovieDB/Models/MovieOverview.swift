//
//  MovieOverview.swift
//  MovieDB
//
//  Created by Mac on 2018/7/28.
//  Copyright © 2018年 Link. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieOverview {
    
    var movieId: Int
    var voteCount: Int
    var video: Bool
    var voteAverage: Int
    var title: String
    var popularity: Float
    var posterPath: String?
    var originalLanguage: String?
    var originalTitle: String
    var genreIds: Array<Int>
    var backdropPath: String?
    var adult: Bool
    var overview:String?
    var releaseDate: String
    
}
extension MovieOverview {
    init(_ json: JSON) {
        movieId = json["id"].intValue
        voteCount = json["vote_count"].intValue
        video = json["video"].boolValue
        voteAverage = json["voteAverage"].intValue
        title = json["title"].stringValue
        popularity = json["popularity"].floatValue
        originalLanguage = json["original_language"].stringValue
        posterPath = json["poster_path"].stringValue
        originalTitle = json["original_title"].stringValue
        genreIds = json["genre_ids"].arrayValue.map {
            $0.intValue }
        backdropPath = json["backdrop_path"].stringValue
        adult = json["adult"].boolValue
        overview = json["overview"].stringValue
        releaseDate = json["release_date"].stringValue
    }
}
