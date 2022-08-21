//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import IGListKit

class ___VARIABLE_moduleName:identifier___Presenter: ___VARIABLE_moduleName:identifier___PresenterProtocol {
    
    weak private var view: ___VARIABLE_moduleName:identifier___ViewProtocol?
    private let interactor: ___VARIABLE_moduleName:identifier___InteractorInputProtocol?
    private let router: ___VARIABLE_moduleName:identifier___RouterProtocol?
    var entity: ___VARIABLE_moduleName:identifier___Entity?
    
    var page = 1
    var length = 10
    
    init(interface: ___VARIABLE_moduleName:identifier___ViewProtocol,  interactor: ___VARIABLE_moduleName:identifier___InteractorInputProtocol?, router: ___VARIABLE_moduleName:identifier___RouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        
    }
    
    func viewDidLoad() {
        
    }
    
}

extension ___VARIABLE_moduleName:identifier___Presenter: ___VARIABLE_moduleName:identifier___InteractorOutputProtocol {
    // MARK: InteractorOutputProtocol
    func requestDidSuccess() {
        
    }
    
    func requestDidFailed(message: String) {
        
    }
}
