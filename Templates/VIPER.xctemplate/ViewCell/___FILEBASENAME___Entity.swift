//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import IGListKit

class ___VARIABLE_moduleName:identifier___Entity: BaseListDiffable {
    
    var id:Int?
    
    init(id:Int?, identifier: Int) {
        self.id = id
        super.init(identifier: identifier)
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let data = object as? ___VARIABLE_moduleName:identifier___Entity {
            return data.id == id
                && data.identifier == identifier
        }
        return false
    }
    
}
