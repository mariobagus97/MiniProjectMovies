//
//  HomeDetailViewController.swift
//  MiniProject
//
//  Created by SehatQ on 22/08/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreData

class HomeDetailViewController: UIViewController {
    
    // MARK: - IBActions
    // Add IBActions in this area
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblReleased: UILabel!
    @IBOutlet weak var lblRuntime: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblActors: UILabel!
    @IBOutlet weak var lblPlot: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var movie: Movie?
    
    var isWishlist = false
    var idMovie: String?
    var presenter: HomeDetailPresenterProtocol?
    var isFromWishlist : Bool = false {
        willSet {
            if newValue {
                isWishlist = true
            }
        }
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getMovieDetail(id: idMovie ?? "")
        setupViews()
    }

    // MARK: - Privates
    private func setupViews() {
        // TODO: Add setting up views here
        setUpMenuButton()
    }
    
    @objc func loveTapped(){
        isWishlist = !isWishlist
        if isWishlist {
            presenter?.saveLocalDB(movie: self.movie)
        } else {
            presenter?.removeItemLocalDB(idMovie: self.idMovie)
        }
        setUpMenuButton()
    }
    
    private func setUpMenuButton(){
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        menuBtn.setImage(UIImage(named: isWishlist == false ? "icUnlove" : "icLove"), for: .normal)
        menuBtn.addTarget(self, action: #selector(loveTapped), for: UIControl.Event.touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
}

// MARK: - View Protocol
extension HomeDetailViewController: HomeDetailViewProtocol {
    func loadingState(state: LoadingState) {
        switch state {
        case .loading:
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        case .finished, .failed, .notLoad:
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimating()
        }
    }
    
    func populateData(movie: Movie) {
        // TODO: Populate data
        self.movie = movie
        self.imgMovie.setImage(movie.poster ?? "")
        self.lblTitle.text = movie.title ?? "-"
        self.lblLanguage.text = movie.language ?? "-"
        self.lblReleased.text = movie.released ?? "-"
        self.lblRuntime.text = movie.runtime ?? "-"
        self.lblGenre.text = movie.genre ?? "-"
        self.lblDirector.text = movie.director ?? "-"
        self.lblActors.text = movie.actors ?? "-"
        self.lblPlot.text = movie.plot ?? "-"
    }

    func showProgressDialog(show: Bool) {
        DispatchQueue.main.async {
        }
    }

    func showAlertMessage(title: String, message: String) {
        DispatchQueue.main.async {
        }
    }

    func showErrorMessage(message: String) {
        DispatchQueue.main.async {
        }
    }
}
