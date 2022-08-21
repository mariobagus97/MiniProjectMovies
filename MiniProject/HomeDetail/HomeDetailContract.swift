//
//  HomeDetailContract.swift
//  MiniProject
//
//  Created by SehatQ on 22/08/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import RxSwift

protocol HomeDetailRouterProtocol: AnyObject {
}

protocol HomeDetailPresenterProtocol: AnyObject {
    var entity: HomeDetailEntity? { get set } 
    func getMovieDetail(id: String)
    func viewDidLoad()
    func saveLocalDB(movie: Movie?)
    func removeItemLocalDB(idMovie: String?)
}

protocol HomeDetailInteractorOutputProtocol: AnyObject {
    func requestDidSuccess()
    func requestDidFailed(message: String)
}

protocol HomeDetailInteractorInputProtocol: AnyObject {
    var output: HomeDetailInteractorOutputProtocol? { get set }
    func getMovieDetail(id: String) -> Observable<Movie?>
    func fetchData()
    func saveLocalDB(movie: Movie)
    func removeItemLocalDB(idMovie: String?)
}

protocol HomeDetailViewProtocol: AnyObject {
    // Presenter -> ViewController
    func populateData(movie: Movie)
    func showProgressDialog(show: Bool)
    func showAlertMessage(title: String, message: String)
    func showErrorMessage(message: String)
    func loadingState(state: LoadingState)
    
}
