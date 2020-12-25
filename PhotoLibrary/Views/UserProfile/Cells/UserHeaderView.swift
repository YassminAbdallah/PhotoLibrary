//
//  UserHeaderView.swift
//  PhotoLibrary
//
//  Created by Yassmin Abdallah on 12/25/20.
//

import UIKit

class UserHeaderView: UIView {

    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor , constant:  16),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: 16) ,
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 16)
        ])
        return label
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: profileLabel.bottomAnchor , constant:  16),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: 16) ,
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 16)
        ])
        return label
    }()
    
    lazy var userAddressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor , constant:  16),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: 16) ,
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 16)
        ])
        return label
    }()
    
    lazy var myAlbumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: userAddressLabel.bottomAnchor , constant:  16),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: 16) ,
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 16)
        ])
        return label
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
