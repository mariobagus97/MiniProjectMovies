//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

protocol ___VARIABLE_moduleName:identifier___RouterProtocol: class {

}

protocol ___VARIABLE_moduleName:identifier___PresenterProtocol: class {
    
    var entity: ___VARIABLE_moduleName:identifier___Entity? { get set } 
    
    func viewDidLoad()

}

protocol ___VARIABLE_moduleName:identifier___InteractorOutputProtocol: class {
    
    func requestDidSuccess()
    func requestDidFailed(message: String)
}

protocol ___VARIABLE_moduleName:identifier___InteractorInputProtocol: class {
    
    var output: ___VARIABLE_moduleName:identifier___InteractorOutputProtocol? { get set }

    func fetchData()
    
}

protocol ___VARIABLE_moduleName:identifier___ViewProtocol: class {
    
    // Presenter -> ViewController
    func populateData()
    func showProgressDialog(show: Bool)
    func showAlertMessage(title: String, message: String)
    func showErrorMessage(message: String)
    
}
