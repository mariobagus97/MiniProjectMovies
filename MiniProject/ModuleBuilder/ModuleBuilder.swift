//
//  ModuleBuilder.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//

import Foundation

class ModuleBuilder {
    
    static let shared = ModuleBuilder()
    
    func createHomeViewController(isWishlist: Bool = false) -> HomeViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        view.isWishlistPage = isWishlist
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interface: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
    func createHomeDetailViewController(idMovie: String, isFromWishlist: Bool = false) -> HomeDetailViewController {
        let view = HomeDetailViewController(nibName: "HomeDetailViewController", bundle: nil)
        view.idMovie = idMovie
        view.isFromWishlist = isFromWishlist
        let interactor = HomeDetailInteractor()
        let router = HomeDetailRouter()
        let presenter = HomeDetailPresenter(interface: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}
