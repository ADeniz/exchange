//
//  exchange_presenter.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation
import UIKit


enum presenterState{
    case calculate
    case confirmation
    case exchange
}

class ExchangePresenter:AnyPresenter{
   
    
    
    
   
    
    var state:presenterState = .calculate
    var successview: SuccesViewProtocol?
    func openListMenu() {
        
    }
    
    var router: AnyRouter
    var interactor: AnyInteractor
    var view: AnyView
    
    init(interactor:AnyInteractor,router:AnyRouter,view:AnyView){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    func oncalculation(calculation: Calculation) {
       
       
        switch self.state{
        case .calculate:
            let response = "Final ammount:\(calculation.target.localeString)"
            let boldlen = calculation.target.localeString.count + 1
            let _text:NSMutableAttributedString =  NSMutableAttributedString(string:response )
            _text.addAttributes([.font:UIFont.systemFont(ofSize: 12, weight: .bold),.foregroundColor:UIColor(named: "darkText") ?? .black], range:NSRange(location:response.count - boldlen, length:boldlen))
            view.setCalculationString(calculation:_text,rate:calculation.rate)
            break
        case .confirmation:
            
 
            let response = "Are you about to get \(calculation.target.localeString) for \(calculation.current.localeString)?\nDo yo approve the transaction"
            let boldlen = calculation.target.localeString.count + 1
            let bold2len = calculation.current.localeString.count + 1
            let _text:NSMutableAttributedString =  NSMutableAttributedString(string:response,attributes:[.font:UIFont.systemFont(ofSize:12)] )
            _text.addAttributes([.font:UIFont.systemFont(ofSize: 12, weight: .bold),.foregroundColor:UIColor(named: "primary") ?? .blue], range:NSRange(location:20, length:boldlen))
            _text.addAttributes([.font:UIFont.systemFont(ofSize: 12, weight: .bold),.foregroundColor:UIColor(named: "primary") ?? .blue], range:NSRange(location:20+boldlen+5, length:bold2len))
            view.confirm(message:_text)
            break
        case .exchange:
            let response = "\(calculation.current.localeString) = \(calculation.target.localeString)"
            let boldlen = calculation.current.localeString.count
            let bold2len = calculation.target.localeString.count
            let _text:NSMutableAttributedString =  NSMutableAttributedString(string:response,attributes:[.font:UIFont.systemFont(ofSize:12)] )
            _text.addAttributes([.font:UIFont.systemFont(ofSize: 12, weight: .bold)], range:NSRange(location:0, length:boldlen))
            _text.addAttributes([.font:UIFont.systemFont(ofSize: 12, weight: .bold)], range:NSRange(location:boldlen+3, length:bold2len))
            if let successview = successview {
                successview.success(message: _text)
            }
            break
            
        }
    }
    func calculate(current: Int, target: Int, value: Double) {
        self.state = .calculate
        interactor.calculate(current: current, target: target, value: value)
    }
    
    func ondata(currencies: [currency]) {
        view.setCurrencies(currencies:  currencies.map{$0.key})
    }
    
    func onstate(state: AnyInteactorState) {
        view.onstate(state: state)
    }
    
    func needConfirm(current: Int, target: Int, value: Double) {
        
        self.calculate(current: current, target: target, value: value)
        self.state = .confirmation
    }
    
    func exchange(current: Int, target: Int, value: Double) {
        self.router.navigate(route: .success)
        if let success = self.router.view as? SuccesViewProtocol{
            self.successview = success
            self.successview?.presenter = self
            self.calculate(current: current, target: target, value: value)
            self.state = .exchange
        }
    }
   
    func close() {
        self.router.pop()
    }
    
    
    func loadData() {
        interactor.loadData()
    }
    
    
}
