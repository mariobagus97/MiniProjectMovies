//
//  HomeViewController.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - IBActions
    // Add IBActions in this area
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblEmptyItem: UILabel!
    
    var searchBar = UISearchBar()
    var presenter: HomePresenterProtocol?
    var isRefreshCell = true
    var page = 1
    var isWishlistPage = false
    
    private var dataSource: [Search]?
    private var cellModels: [itemHome]? = []
    private var searchText = ""
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !isWishlistPage {
            lblEmptyItem.text = "Silahkan ketik di kolom pencarian atas"
            setupNavigationBar()
        } else {
            self.navigationItem.title = "Wishlist"
            if #available(iOS 13, *) {
                let appearance = UINavigationBarAppearance()
                appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(hexString: "#161B22")
                
                navigationItem.standardAppearance = appearance
                navigationItem.scrollEdgeAppearance = appearance
            }
            presenter?.getDataFromLocal()
            lblEmptyItem.text = "Wishlist anda kosong"
        }
        isRefreshCell = true
    }
    
    // MARK: - Privates
    // Add privates functions here
    private func setupViews() {
        // TODO: Add setting up views here
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let headerNib = UINib(nibName: String(describing: MovieCollCell.self), bundle: nil)
        collectionView.register(headerNib, forCellWithReuseIdentifier: String(describing: MovieCollCell.self))
        let loadingNib = UINib(nibName: String(describing: LoadingCell.self), bundle: nil)
        collectionView.register(loadingNib, forCellWithReuseIdentifier: String(describing: LoadingCell.self))
    }
    
    private func setupNavigationBar(){
        searchBar.delegate = self
        searchBar.placeholder = "Naruto..."
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Wishlist", style: .plain, target: self, action: #selector(wishListTapped))
        self.navigationItem.hidesBackButton = true
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(hexString: "#161B22")
        
        // MARK:ini handle issue di ios 15
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(hexString: "#161B22")
            self.navigationController?.navigationBar.standardAppearance = appearance;
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        }
    }
    
    @objc func wishListTapped(){
        presenter?.moveToVc(vc: ModuleBuilder.shared.createHomeViewController(isWishlist: true))
    }
    
    private func loadMore() {
        presenter?.searchMovie(value: self.searchText)
    }
}

// MARK: - View Protocol
extension HomeViewController: HomeViewProtocol {
    func populateData(dataSource: [Search]?, cellModels: [itemHome]?) {
        self.dataSource = dataSource
        self.cellModels = cellModels
    }
    
    func loadingState(state: LoadingState) {
        switch state {
        case .loading:
            print("loading")
        case .finished, .failed, .notLoad:
            print(state)
            self.collectionView.reloadData()
        }
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

// MARK: CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = dataSource?.count, count > 0 {
            lblEmptyItem.isHidden = true
            return count
        }
        lblEmptyItem.isHidden = false
        return self.dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.cellModels?[indexPath.row] {
        case .cardMovie:
            if let cellModel = self.dataSource?[indexPath.row], let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollCell.self), for: indexPath) as? MovieCollCell {
                cell.configureCell(movie: cellModel)
                return cell
            }
        case .loadingPage:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LoadingCell.self), for: indexPath) as? LoadingCell {
                cell.actIndicator.startAnimating()
                cell.configureCell(width: UIScreen.main.bounds.size.width - 40)
                
                if !isRefreshCell {
                    loadMore()
                    isRefreshCell = true
                    return cell
                }
                isRefreshCell = false
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.cellModels?[indexPath.row] == .cardMovie {
            if let cellModel = self.dataSource?[indexPath.row], let idMovie = cellModel.imdbID {
                let vc = ModuleBuilder.shared.createHomeDetailViewController(idMovie: idMovie, isFromWishlist: self.isWishlistPage)
                self.presenter?.moveToVc(vc: vc)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 2.3, height: UIScreen.main.bounds.size.height * 0.4)
    }
}

// MARK: UISearchBarDelegate
extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.page = 1
        self.dataSource?.removeAll()
        self.cellModels = []
        self.isRefreshCell = true
        
        if !searchText.isEmpty{
            self.searchText = searchText
            presenter?.searchMovie(value: searchText)
        } else {
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
