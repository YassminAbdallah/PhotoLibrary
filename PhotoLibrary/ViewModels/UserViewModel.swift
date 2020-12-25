//
//  UserModel.swift
//  PhotoLibrary
//
//  Created by Yassmin Abdallah on 12/24/20.
//


import Foundation
import RxSwift
import RxCocoa


class UserViewModel {
    //
    let  networkHandler =  RequestsHandler()
    //
    let dispose = DisposeBag()
    let isLoaded = PublishSubject<Bool>()
    //
    var usersData : [DTOUser]?
    var albumData : [DTOAlbums]?
    var photosData : [DTOPhotos]?
    var searchPhotoResult: [DTOPhotos]?
    
    //
    var selectedAlbum : DTOAlbums?
    var selectedPhoto : DTOPhotos?
    //
    
    var isSearching = false
    
    //MARK: - get users  -
    func getUsers()
    {
        networkHandler.getUsers().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self](users) in
            self?.usersData = users
            guard let userID = self?.usersData?.first?.id else { self?.isLoaded.on(.next(false))
                return }
            self?.getAlbums(userID: "\(userID)")
        }, onError: { [weak self](error) in
            self?.isLoaded.onError(error)
        }).disposed(by: dispose)
    }
    
    //MARK: - get album  -
    func getAlbums(userID : String)
    {
        networkHandler.getAlbums(userID: userID).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self](albums) in
            self?.albumData = albums
            self?.isLoaded.on(.next(true))
        }, onError: { [weak self](error) in
            self?.isLoaded.onError(error)
        }).disposed(by: dispose)
    }
    
    
    //MARK: - get album  -
    func getPhotos(albumID : String)
    {
        networkHandler.getPhotos(albumID: albumID).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self](photos) in
            self?.photosData = photos
            self?.isLoaded.on(.next(true))
        }, onError: { [weak self](error) in
            self?.isLoaded.onError(error)
        }).disposed(by: dispose)
    }
    
    //
    func albumViewModelForIndexPath(index: Int) -> UserViewModel {
        let userModel = UserViewModel()
        let album = albumData?[index]
        userModel.selectedAlbum = album
        return userModel
    }
    
    //
    func imageZoomViewModelForIndexPath(index: Int) -> UserViewModel {
        let userModel = UserViewModel()
        let photo = self.photoData()?[index]
        userModel.selectedPhoto = photo
        return userModel
    }
    
    //
    func photoData () -> [DTOPhotos]?
    {
        if self.isSearching
        {
           return searchPhotoResult
        }
        else {
            return photosData
        }
    }
    
    //photo search
    func searchPhotos(title : String)
    {
        searchPhotoResult = [DTOPhotos]()
        searchPhotoResult = photosData?.filter({($0.title?.lowercased().contains(title.lowercased()))! })
    }
}

