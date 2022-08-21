//
//  HomePresenter.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum itemHome {
    case cardMovie
    case loadingPage
}

class HomePresenter: BasePresenter, HomePresenterProtocol {
    
    var entity: HomeEntity?
    
    weak private var view: HomeViewProtocol?
    private let interactor: HomeInteractorInputProtocol?
    private let router: HomeRouterProtocol?
    private var page = 1
    private var dataSource: [Search]? = []
    private var cellModels : [itemHome]? = []
    
    
    init(interface: HomeViewProtocol, interactor: HomeInteractorInputProtocol?, router: HomeRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    // MARK: PresenterProtocol
    func viewDidLoad() {
        // TODO: Add on view loaded
    }
    
    func searchMovie(value: String) {
        self.view?.loadingState(state: .loading)
        
        interactor?.SearchMovie(title: value, page: 1)
            .catch({ [weak self] error -> Observable<HomeEntity?> in
                self?.alertError.onNext(error.localizedDescription)
                self?.view?.loadingState(state: .failed)
                return Observable.just(nil)
            })
            .subscribe(onNext: {[unowned self] homeEntity in
                buildCell(listData: homeEntity?.search)
                page += 1
                self.view?.loadingState(state: .finished)
            }).disposed(by: disposeBag)
    }
    
    func moveToVc(vc: UIViewController) {
        router?.moveToVc(vc: vc)
    }
    
    
    func getDataFromLocal() {
        self.view?.loadingState(state: .loading)
        interactor?.fetchLocalDB()
        self.view?.loadingState(state: .finished)
    }
    
    // MARK: private func
    private func buildCell(listData : [Search]?) {
        dataSource?.removeAll()
        cellModels?.removeAll()
        
        guard let datas = listData else { return }
        for item in datas {
            dataSource?.append(item)
        }
        
        guard let dataSource = dataSource else { return }
        for _ in dataSource {
            cellModels?.append(itemHome.cardMovie)
        }
        cellModels?.append(itemHome.loadingPage)
        
        view?.populateData(dataSource: self.dataSource, cellModels: self.cellModels)
    }

}

extension HomePresenter: HomeInteractorOutputProtocol {
   
    // MARK: InteractorOutputProtocol
    func requestDidSuccess(moviesLocalDB: [MovieLocalEntity]) {
        var searchArr: [Search] = []
        for movieDB in moviesLocalDB {
            searchArr.append(Search(title: movieDB.title, year: movieDB.released, imdbID: movieDB.idMovie, type: nil, poster: movieDB.image))
        }
        buildCell(listData: searchArr)
    }

    func requestDidFailed(message: String) {
    }

}
