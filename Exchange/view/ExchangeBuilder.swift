//
//  ExchangeBuilder.swift
//  exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import UIKit
final class ExchangeBuilder {
    
    static func make(nav:UINavigationController) -> ExchangeView {
        
        let view = ExchangeView.newInstance(identifier: ExchangeView.identifier) as! ExchangeView
        let router = ExchangeRouter(view: view,nav: nav)
        let interactor = ExchangeInteractor()
        let presenter = ExchangePresenter(interactor: interactor, router: router, view: view)
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}
