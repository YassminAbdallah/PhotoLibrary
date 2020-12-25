//
//  ImageZoomViewController.swift
//  PhotoLibrary
//
//  Created by Yassmin Abdallah on 12/25/20.
//

import UIKit
import RxSwift
import RxCocoa

class ImageZoomViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
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
        self.title = userModel.selectedPhoto?.title ?? ""
        setImage()
        setShareNavigationButton()
    }

    //
    func setShareNavigationButton()
    {
        let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.action, target: self, action: #selector(share))
        self.navigationItem.rightBarButtonItem = shareBar
    }

    //MARK: - image view -
    func setImage()
    {
        imageView.setImage(urlString: userModel.selectedPhoto?.url ?? "")
        imageView.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(sender:)))
        imageView.addGestureRecognizer(pinchGesture)
        
    }
    
    //
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1
    }

    //MARK: - share -
    @objc func share()
    {
        let activityItem = [self.imageView.image]
        let avc = UIActivityViewController(activityItems: activityItem as [Any], applicationActivities: nil)
        self.present(avc, animated: true, completion: nil)
    }
    
    
}
