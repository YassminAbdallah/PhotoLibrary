//
//  UserProfileViewController.swift
//  PhotoLibrary
//
//  Created by Yassmin Abdallah on 12/24/20.
//

import UIKit
import RxSwift
import RxCocoa


class UserProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        }
    }
    //
    private let userModel = UserViewModel()
    private let dispose = DisposeBag()
    

    //MARK: - life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        getUsers()
        observers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }


    //MARK: - -
    func getUsers()
    {
        userModel.getUsers()
    }
    
    //MARK: - -
    func observers() {
        //
        userModel.isLoaded.subscribe(onNext: { [weak self](bool) in
           //reload
            if bool {
                self?.tableView.reloadData()
            }
        }).disposed(by: dispose)
        //
    }


}


extension UserProfileViewController : UITableViewDelegate , UITableViewDataSource
{
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModel.albumData?.count ?? 0
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") ?? UITableViewCell()
        cell.textLabel?.text = userModel.albumData?[indexPath.row].title ?? ""
        return cell
    }
    
    //
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UserHeaderView()
        view.profileLabel.text = "Profile"
        view.userNameLabel.text = userModel.usersData?.first?.name ?? ""
        view.userAddressLabel.text = "\(userModel.usersData?.first?.address?.city ?? ""), \(userModel.usersData?.first?.address?.suite ?? ""), \(userModel.usersData?.first?.address?.city ?? ""), \(userModel.usersData?.first?.address?.zipcode ?? "")"
        view.myAlbumLabel.text = "My Albums"

        return view
    }
    
    //
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumViewController =  UserAlbumViewController(viewModel: userModel.albumViewModelForIndexPath(index: indexPath.row))
        self.navigationController?.pushViewController(albumViewController, animated: true)
        
    }
}
