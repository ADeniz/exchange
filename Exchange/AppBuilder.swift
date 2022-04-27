//
//  AppRouter.swift
//  exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import UIKit
class AppBuilder{
    
    static func make()->UIViewController{
        let navigationController = UINavigationController()
        let viewController = ExchangeBuilder.make(nav:navigationController)
        navigationController.setViewControllers([viewController], animated: false)
        
        return navigationController
    }
    
    
}
