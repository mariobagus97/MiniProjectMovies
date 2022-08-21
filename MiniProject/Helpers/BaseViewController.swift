//
//  BaseViewController.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//


import UIKit
import RxSwift
import RxCocoa

protocol refreshProtocol {
    func Refresh()
}

class BaseViewController: UIViewController {
    internal let disposeBag = DisposeBag()
//    var presenter: BasePresenter?
    internal let refreshControl = UIRefreshControl()
    var delegate : refreshProtocol?
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter?.alertError
//                   .asObservable()
//                   .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
//                .observe(on: MainScheduler.instance)
//                   .subscribe(onNext: { (msgError) in
//                       if !msgError.isEmpty{
//                           self.showAlert(title: "Kesalahan", message: msgError)
//                       }
//                   }).disposed(by: disposeBag)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    }
    
    func showAlert(title : String, message : String) {
        let uialert = UIAlertController(title: title, message: message
                                        , preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Refresh", style: .default) {
            UIAlertAction in
            print("refresh")
            self.delegate?.Refresh()
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel) {
            _ in
            print("Cancel Pressed")
        }
        uialert.addAction(okAction)
        uialert.addAction(cancelAction)
        self.present(uialert, animated: true, completion: nil)
    }
    
    @objc func refresh()
    {
    }
}
