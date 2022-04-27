//
//  Router.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation
import UIKit

class ExchangeRouter:AnyRouter{
    var nav:UINavigationController?
    var view:routedview
    init(view:routedview,nav:UINavigationController){
        self.view = view
        self.nav = nav
        
    }
    
    func pop() {
        if let nav  = self.view.navigationController{
            if let controller = nav.popViewController(animated: true) as? routedview{
                view  = controller
            }
            
        }
    }
    func navigate(route:AnyRoute){
        if route == .success{
            let routed = UIViewController.newInstance(identifier: route.rawValue)
            if let nav = self.nav,let routed = routed {
                nav.pushViewController(routed, animated:true)
                if let casted = routed as? routedview{
                    self.view = casted
                }
               
            }
            
        }
    }
  
    
    func start(){
        
    }
    
    
}
