//
//  HomeDetailPresenter.swift
//  MiniProject
//
//  Created by SehatQ on 22/08/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift

class HomeDetailPresenter: BasePresenter, HomeDetailPresenterProtocol {
    
    weak private var view: HomeDetailViewProtocol?
    private let interactor: HomeDetailInteractorInputProtocol?
    private let router: HomeDetailRouterProtocol?

    var entity: HomeDetailEntity?
    
    init(interface: HomeDetailViewProtocol, interactor: HomeDetailInteractorInputProtocol?, router: HomeDetailRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    // MARK: PresenterProtocol

    func viewDidLoad() {
        // TODO: Add on view loaded
    }
    
    func getMovieDetail(id: String) {
        self.view?.loadingState(state: .loading)
        
        interactor?.getMovieDetail(id: id)
            .catch({ [weak self] error -> Observable<Movie?> in
                self?.alertError.onNext(error.localizedDescription)
                self?.view?.loadingState(state: .failed)
                return Observable.just(nil)
            })
            .subscribe(onNext: {[unowned self] movie in
                guard let movie = movie else {
                    self.view?.loadingState(state: .failed)
                    return
                }
                view?.populateData(movie: movie)
                self.view?.loadingState(state: .finished)
            }).disposed(by: disposeBag)
    }
    
    func saveLocalDB(movie: Movie?) {
        guard let movie = movie else { return }
        interactor?.saveLocalDB(movie: movie)
    }
    
    func removeItemLocalDB(idMovie: String?) {
        interactor?.removeItemLocalDB(idMovie: idMovie)
    }
}

extension HomeDetailPresenter: HomeDetailInteractorOutputProtocol {

    // MARK: InteractorOutputProtocol

    func requestDidSuccess() {
        view?.showProgressDialog(show: false)
//        view?.populateData()
    }

    func requestDidFailed(message: String) {
        view?.showProgressDialog(show: false)
        view?.showErrorMessage(message: message)
    }

}
