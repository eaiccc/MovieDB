//
//  Movie.swift
//  MovieDB
//
//  Created by Mac on 2018/7/28.
//  Copyright © 2018年 Link. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {
    var adult: Bool
    var backdropPath: String?
    var belongsToCollection: String?
    var budget: Int
    var genres:[Genres]
    var homepage: String?
    var movieId: Int
    var imdbId: String?
    var originalLanguage: String
    var originalTitle: String
    var overview:String
    var popularity: Float
    var posterPath: String?
    var releaseDate: String
    var revenue: Int
    var runtime: Int
    var status: String
    var tagline: String
    var title: String
    var video:Bool
    var voteCount: Int
    var voteAverage: Int
    var spokenLanguages:[SpokenLanguage]
    
}

extension Movie {
    init(_ json: JSON) {
        movieId = json["id"].intValue
        voteCount = json["vote_count"].intValue
        video = json["video"].boolValue
        voteAverage = json["voteAverage"].intValue
        budget = json["budget"].intValue
        title = json["title"].stringValue
        popularity = json["popularity"].floatValue
        originalLanguage = json["original_language"].stringValue
        posterPath = json["poster_path"].stringValue
        originalTitle = json["original_title"].stringValue
        homepage = json["homepage"].stringValue
        imdbId = json["imdbId"].stringValue
        imdbId = json["imdbId"].stringValue
        belongsToCollection = json["belongs_to_collection"].stringValue
        adult = json["adult"].boolValue
        overview = json["overview"].stringValue
        releaseDate = json["release_date"].stringValue
        revenue = json["revenue"].intValue
        runtime = json["runtime"].intValue
        status = json["status"].stringValue
        tagline = json["tagline"].stringValue
        spokenLanguages = json["spoken_languages"].arrayValue.map { SpokenLanguage($0) }
        genres = json["genres"].arrayValue.map { Genres($0) }
    }
    
    var popularityString: String {
        return String(format: "%.1f",  popularity)
    }
    
    var runtimeString: String {
        let hour:Int = runtime / 60
        let min:Int = runtime % 60
        if (hour > 0 ) {
            return String(format: "%d h %d m",  hour, min)
        }else {
            return String(format: "%d m", min)
        }
    }
    

    
    
    
}
