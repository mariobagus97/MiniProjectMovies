//
//  HomeInteractor.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var output: HomeInteractorOutputProtocol?
    
    func fetchData() {
    }
    
    func SearchMovie(title: String, page: Int) -> Observable<HomeEntity?> {
        return UrlBuilder<HomeEntity>()
            .SetUrl(urlSegment: "")
            .AddParameter(key: "page", value: page)
            .AddParameter(key: "s", value: title)
            .Execute(httpMethod: .get)
    }
    
    func fetchLocalDB() {
        var movieLocalDB : [MovieLocalEntity] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MovieLocalEntity>(entityName: "MovieLocalEntity")
        
        do {
            movieLocalDB = try managedContext.fetch(fetchRequest)
            output?.requestDidSuccess(moviesLocalDB: movieLocalDB)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

}
