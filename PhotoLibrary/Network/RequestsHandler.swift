//
//  RequestsHandler.swift
//  PhotoLibrary
//
//  Created by Yassmin Abdallah on 12/24/20.
//

import Foundation
import RxSwift
import Moya

class  RequestsHandler {
    
    private let provider = MoyaProvider<User>()

    func getUsers() -> Observable<[DTOUser]>{
        return provider.rx.request(.users) .filterSuccessfulStatusAndRedirectCodes().map([DTOUser].self).asObservable()
    }

    func getAlbums(userID:String) -> Observable<[DTOAlbums]>{
        return provider.rx.request(.albums(userID: userID)) .filterSuccessfulStatusAndRedirectCodes().map([DTOAlbums].self).asObservable()
    }

    func getPhotos(albumID:String) -> Observable<[DTOPhotos]>{
        return provider.rx.request(.photos(albumsID:albumID)) .filterSuccessfulStatusAndRedirectCodes().map([DTOPhotos].self).asObservable()
    }
    

}
