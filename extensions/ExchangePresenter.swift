//
//  exchange_presenter.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation

class ExchangePresenter:AnyPresenter{
    var router: AnyRouter
    var interactor: AnyInteractor
    var view: AnyView
    
    init(interactor:AnyInteractor,router:AnyRouter,view:AnyView){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func calculate(current: Int, target: Int, value: Double) {
        interactor.calculate(current: current, target: target, value: value)
    }
    
    func ondata(currencies: [currency]) {
        view.setCurrencies(currencies:  currencies.map{$0.key})
    }
    
    func onstate(state: AnyInteactorState) {
        view.onstate(state: state)
    }
    
    func oncalculation(result: currency) {
        let symbol = interactor.symbolforcurrency(Currency: result) ?? result.key
        view.setCalculationString(calculation:"\(result.value.toFixedSizeLocaleStringIfNedded(len: 2))\(symbol)")
    }
    
 
    
    func loadData() {
        interactor.loadData()
    }
    
    
}
