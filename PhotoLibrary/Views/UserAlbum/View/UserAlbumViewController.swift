//
//  UserAlbumViewController.swift
//  PhotoLibrary
//
//  Created by Yassmin Abdallah on 12/24/20.
//

import UIKit
import RxSwift
import RxCocoa

class UserAlbumViewController: UIViewController {
    
    var isSearch = false
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.placeholder = "Search by photo title"
            searchBar.delegate = self
        }
    }
    //
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "UserAlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserAlbumCollectionViewCell")

        }
    }
    //
    private var userModel = UserViewModel()
    private let dispose = DisposeBag()
    
    
    //MARK: - Init -
    init(viewModel: UserViewModel) {
        self.userModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userModel.selectedAlbum?.title ?? ""
        getPhotos()
        observers()
    }

    
    //MARK: - -
    func getPhotos()
    {
        userModel.getPhotos(albumID: "\(userModel.selectedAlbum?.id ?? 0)")
    }
    
    //MARK: - -
    func observers() {
        //
        userModel.isLoaded.subscribe(onNext: { [weak self](bool) in
           //reload
            if bool {
                self?.collectionView.reloadData()
            }
        }).disposed(by: dispose)
        //
    }

}


extension UserAlbumViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userModel.photoData()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserAlbumCollectionViewCell", for: indexPath) as! UserAlbumCollectionViewCell
        cell.imageView.setImage(urlString: userModel.photoData()?[indexPath.row].thumbnailUrl ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageZoomViewController =  ImageZoomViewController(viewModel: userModel.imageZoomViewModelForIndexPath(index: indexPath.row))
        self.navigationController?.pushViewController(imageZoomViewController, animated: true)
    }
}

extension UserAlbumViewController : UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  self.collectionView.bounds.size.width/3  , height: self.collectionView.bounds.size.width/3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


extension UserAlbumViewController : UISearchBarDelegate
{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       search(searchBar)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         cancelSearch(searchBar)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar)
    }
    
    func search(_ searchBar: UISearchBar)
    {
        self.isSearch = true
        self.searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = true
        if searchBar.text != nil || !(searchBar.text?.isEmpty)! {
            userModel.isSearching = true
            userModel.searchPhotos(title: searchBar.text ?? "")
            collectionView.reloadData()
        }
        else
        {
            cancelSearch(searchBar)
        }
    }
    
    func cancelSearch(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        userModel.isSearching = false
        searchBar.text = ""
        collectionView.reloadData()
    }
}
