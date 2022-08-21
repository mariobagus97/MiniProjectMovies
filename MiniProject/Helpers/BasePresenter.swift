//
//  BasePresenter.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//
import Foundation
import RxSwift
import RxCocoa

enum LoadingState: Int {
    case notLoad
    case loading
    case finished
    case failed
}

class BasePresenter : NSObject {
    var alertError :  PublishSubject<String> = PublishSubject()
    var disposeBag = DisposeBag()
//    var state = BehaviorRelay<LoadingState>(value: .notLoad)
}
