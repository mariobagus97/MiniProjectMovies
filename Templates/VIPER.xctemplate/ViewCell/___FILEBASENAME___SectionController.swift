//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import IGListKit

class ___VARIABLE_moduleName:identifier___SectionController: ListSectionController {
    
    var presenter: ___VARIABLE_moduleName:identifier___PresenterProtocol?
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else {
            return .zero
        }
        return HomeHorizontalCell.size(containerWidth: width)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = dequeueCellByNib(at: index) as UICollectionViewCell//HomeHorizontalCell
        guard let entity = presenter?.entity else {
            return cell
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        presenter?.entity = object as? ___VARIABLE_moduleName:identifier___Entity
    }
    
    override func didSelectItem(at index: Int) {
        guard let entity = presenter?.entity else {
            return
        }
        
    }
    
}

//MARK: - View Protocol
extension ___VARIABLE_moduleName:identifier___SectionController: ___VARIABLE_moduleName:identifier___ViewProtocol {
    func updateList() {
        DispatchQueue.main.async {
            
        }
    }
    
    func showProgressDialog(show: Bool) {
        DispatchQueue.main.async {
            
        }
    }
    
    func showAlertMessage(title: String, message: String) {
        DispatchQueue.main.async {
            
        }
    }
    
    func showErrorMessage(message: String) {
        DispatchQueue.main.async {
            
        }
    }
}
