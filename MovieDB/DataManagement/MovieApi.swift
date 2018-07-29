//
//  MovieApi.swift
//  MovieDB
//
//  Created by Link on 2018/7/27.
//  Copyright © 2018年 Link. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


// MARK: - Api Results
enum ApiResult<Value> {
    case success(value: Value)
    case failure(error: NSError)
    
    init(_ f: () throws -> Value) {
        do {
            let value = try f()
            self = .success(value: value)
        } catch let error as NSError {
            self = .failure(error: error)
        }
    }
    
    @discardableResult
    func unwrap() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}


// MARK: - Endpoints
enum Endpoint {
    case discoverMovie
    case movieDetail(movieId: String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        //case .login:
        //    return .post
        case .discoverMovie, .movieDetail:
            return .get
       // case :
        //    return .delete
        //case :
        //    return .put
        }
    }
    
    var path: String {
        switch self {
        case .discoverMovie: return "discover/movie"
        case .movieDetail(let movieId): return "movie/\(movieId)"
        }
    }
    
    var encoding: Alamofire.ParameterEncoding {
    
        switch self {
        case .discoverMovie, .movieDetail:
            return URLEncoding.default
        }
    }
}

// MARK: - Movie Api
class MovieApi {
    // MARK: - Public Methods
    static func apiRequestWithEndPoint(_ endpoint: Endpoint, params: [String: AnyObject]? = nil, response: @escaping (DataResponse<JSON>) -> Void) {
        
        let url = URL.getBaseURL().URLByAppendingEndpoint(endpoint)
        
        var finalParams = (params == nil) ? [String: AnyObject]() : params!
        finalParams["api_key"] = (APIKey) as AnyObject
        let header: HTTPHeaders = HTTPHeaders()
    
        Alamofire.request(url, method: endpoint.method, parameters: finalParams, encoding: endpoint.encoding, headers: header).apiResponseJSON { responseData in
            
            response(responseData)
        }
    }
    
    //primary_release_date.lte=2016-12-31&sort_by=release_ date.desc&page=1
    static func getDiscoverMovie(_ releaseDate: String, sortBy: String, page: Int,  completion: @escaping (ApiResult<DiscoverMovie>) -> Void) {
        let parameters: [String: AnyObject] = ["primary_release_date.lte": releaseDate as AnyObject, "sort_by": sortBy as AnyObject, "page": page as AnyObject]
        self.apiRequestWithEndPoint(.discoverMovie, params: parameters) { response in
            switch response.result {
            case .success(let json):
                let discoverMovie = DiscoverMovie(json)
                completion(ApiResult { return discoverMovie })
            case .failure(let error):
                completion(ApiResult { throw error })
            }
        }
    }
    
    static func getMovieDetail(_ movieId: String, completion: @escaping (ApiResult<Movie>) -> Void) {
        
        self.apiRequestWithEndPoint(.movieDetail(movieId: movieId), params: nil) { response in
            switch response.result {
            case .success(let json):
                let movie = Movie(json)
                completion(ApiResult { return movie })
            case .failure(let error):
                completion(ApiResult { throw error })
            }
        }
    }
}
