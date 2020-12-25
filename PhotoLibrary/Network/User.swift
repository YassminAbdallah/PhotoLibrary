//
//  UserService.swift
//  PhotoLibrary
//
//  Created by Yassmin Abdallah on 12/24/20.
//

import Moya

public enum User  {
    case users
    case albums(userID:String)
    case photos(albumsID:String)
}


//MARK: - Target type -
extension User : TargetType {
    
    //
    public var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    //
    public var path: String {
        switch self {
        case .users:
            return "/users"
        case .albums:
            return "/albums"
        case .photos:
            return "/photos"
        }
    }
    
    //
    public var method: Moya.Method {
        switch self {
        case .users , .albums , .photos: return .get
        }
    }
    
    //
    public var sampleData: Data {
        return Data()
    }
    
    //
    public var task: Task {
        switch self {
        case .users:
            return  .requestPlain
        case .albums(let userID):
            return .requestParameters(parameters: ["userId": userID], encoding: URLEncoding.queryString)
        case .photos(let albumID):
            return .requestParameters(parameters: ["albumId": albumID], encoding: URLEncoding.queryString)
        }
    }
    
    //
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    //
    public var validationType: ValidationType {
        return .successCodes
    }
}
