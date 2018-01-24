//
//  Api.swift
//  iTunes-API-ios
//
//  Created by konojunya on 2018/01/24.
//  Copyright © 2018年 konojunya. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiRouter {
    var path: String { get }
    var method: ApiMethod { get }
}

enum ApiMethod {
    case Get
    case Post
}

enum Result<T, E> {
    case success(T)
    case failure(E)
}

class Api {
    private var router: ApiRouter
    private var parameters: [String: Any] = [String: Any]()
    private var host: String {
        return "https://itunes.apple.com"
    }
    
    private var request: URLRequest? {
        let baseUrl = self.host + self.router.path
        guard let url: URL = .init(string: baseUrl)! else {
            return nil
        }
        let request: URLRequest = .init(url: url)
        return request
    }
    
    private init(router: ApiRouter) {
        self.router = router
    }
    
    static func Create(router: ApiRouter) -> Api {
        return .init(router: router)
    }
    
    func parameters(_ params: [String: Any]) -> Self {
        self.parameters = params
    }
    
    func request<T>(response: T) -> Result<T, Error> {
        Alamofire.request(self.request!)
            .response { result, _, _ in
                if let result = result {
                    return .success(T)
                } else {
                    return .failure(Error)
                }
            }
    }
}

extension Api {
    struct Feed {
        enum Router: ApiRouter {
            case music
            
            var path: String {
                switch self {
                case .music:
                    return "/search"
                }
            }
            
            var method: ApiMethod {
                switch self {
                case .music:
                    return .Get
                }
            }
        }
        
        static func getMusics() -> Result<[Music], Error> {
            var params = [String: Any]()
            params["term"] = "AAA"
            params["media"] = "music"
            params["entity"] = "musicTrack"
            params["country"] = "jp"
            params["lang"] = "jp_JP"
            
            return Api.Create(router: self.Router.music)
                    .parameters(params)
                    .request()
        }
    }
}

struct Music: Codable {
    var artistName: String
    var musicName: String
    var artworkUrl: String
}

