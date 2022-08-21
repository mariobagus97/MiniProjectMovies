//
//  UrlBuilder.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//
import Foundation
import Alamofire
import RxSwift

class UrlBuilder<T: Codable> {
    
    private let baseUrl = "https://www.omdbapi.com/?apikey=389c113"
    private var headers : HTTPHeaders = [:]
    private var URL = ""
    private var parameters: Parameters = [:]
    
    
    func SetUrl(urlSegment : String) -> UrlBuilder {
        self.URL = baseUrl + urlSegment
        return self
    }

    func SetBasicHeader() -> UrlBuilder {
        return self
    }
    
    func AddParameter(key : String, value : Any) -> UrlBuilder {
        self.parameters.updateValue(value, forKey: key)
        print(parameters)
        return self
    }
    
    func AddHeader(key : String, value : String) -> UrlBuilder {
        self.headers.updateValue(value, forKey: key)
        return self
    }
    
    func Execute(httpMethod : HTTPMethod) -> Observable<T?> {
        
         Observable<T?>.create { (observer) -> Disposable in
            Alamofire.request(self.URL, method: httpMethod, parameters: self.parameters ,encoding: URLEncoding.default, headers: self.headers)
                .validate()
                .responseJSON{ (response) in
                    
                    print(response.response?.statusCode)
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    switch response.result {
                    case .success(let json ) :
                        do {
                            print(json)
                            let Response = try decoder.decode(T.self, from: response.data!)
                            print(Response)
                            observer.onNext(Response)
                            observer.onCompleted()
                        } catch (let err) {
                            print(err)
                            observer.onError(err)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }
}

