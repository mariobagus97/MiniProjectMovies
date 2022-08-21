//
//  HomeDetailInteractor.swift
//  MiniProject
//
//  Created by SehatQ on 22/08/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class HomeDetailInteractor: HomeDetailInteractorInputProtocol {
    
    weak var output: HomeDetailInteractorOutputProtocol?
    
    func fetchData() {
    }
    
    func removeItemLocalDB(idMovie: String?) {
        guard let idMovie = idMovie else {
            return
        }

        var movieLocalDB : [MovieLocalEntity] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MovieLocalEntity>(entityName: "MovieLocalEntity")
        
        do {
            movieLocalDB = try managedContext.fetch(fetchRequest)
            
            if movieLocalDB.count > 0{
                for object in movieLocalDB {
                    if object.idMovie == idMovie {
                        print(object)
                        managedContext.delete(object as NSManagedObject)
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getMovieDetail(id: String) -> Observable<Movie?> {
        return UrlBuilder<Movie>()
            .SetUrl(urlSegment: "")
            .AddParameter(key: "i", value: id)
            .Execute(httpMethod: .get)
    }
    
    func saveLocalDB(movie: Movie) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieLocalEntity", in: managedContext)!
        let movieDB = NSManagedObject(entity: entity, insertInto: managedContext)
        
        movieDB.setValue(movie.poster, forKeyPath: "image")
        movieDB.setValue(movie.year, forKeyPath: "released")
        movieDB.setValue(movie.title, forKeyPath: "title")
        movieDB.setValue(movie.imdbID, forKeyPath: "idMovie")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
