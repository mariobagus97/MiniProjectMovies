//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct ___VARIABLE_moduleName:identifier___Entity: Codable, DefaultsSerializable {
    var data: [___VARIABLE_moduleName:identifier___EntityModel]?
    var meta: Meta___VARIABLE_moduleName:identifier___Model?
    var status: StatusModel
}

struct ___VARIABLE_moduleName:identifier___EntityModel: Codable, DefaultsSerializable {
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
    }
    
}

struct Meta___VARIABLE_moduleName:identifier___Model: Codable {
    var pagination: Pagination___VARIABLE_moduleName:identifier___Model
    var imagePath: String
    var videoPath: String?
    
    enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
        case imagePath = "image_path"
        case videoPath = "video_path"
    }
}

struct Pagination___VARIABLE_moduleName:identifier___Model: Codable {
    var currentPage: Int
    var perPage: Int
    var total: Int
    var totalPage: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case perPage = "per_page"
        case total = "total"
        case totalPage = "total_page"
    }
}
