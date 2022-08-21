//
//  HomeContract.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

protocol HomeRouterProtocol: AnyObject {
    func moveToVc(vc: UIViewController)
}

protocol HomePresenterProtocol: AnyObject {
    var entity: HomeEntity? { get set }
    func viewDidLoad()
    func searchMovie(value: String)
    func getDataFromLocal()
    func moveToVc(vc: UIViewController)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func requestDidSuccess(moviesLocalDB: [MovieLocalEntity])
    func requestDidFailed(message: String)
}

protocol HomeInteractorInputProtocol: AnyObject {
    var output: HomeInteractorOutputProtocol? { get set }
    func fetchData()
    func fetchLocalDB()
    func SearchMovie(title: String, page: Int) -> Observable<HomeEntity?>
}

protocol HomeViewProtocol: AnyObject {
    // Presenter -> ViewController
    func populateData(dataSource: [Search]?, cellModels: [itemHome]?)
    func showProgressDialog(show: Bool)
    func showAlertMessage(title: String, message: String)
    func showErrorMessage(message: String)
    func loadingState(state: LoadingState)
}
