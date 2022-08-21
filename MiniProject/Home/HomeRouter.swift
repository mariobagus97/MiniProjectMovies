//
//  HomeRouter.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {
    weak var viewController: HomeViewController?

     // MARK: RouterProtocol
    func moveToVc(vc: UIViewController) {
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
