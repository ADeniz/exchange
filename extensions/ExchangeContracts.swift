//
//  ExchangeContracts.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation
import UIKit




protocol IStorable {
    /**
     key use for userdefaults key name
     */
   static var key:String{
        get set
    }
    /**
     this method giv guarantee about any IStorable can convert to type of Data
     */
    func encoded()->Data?
}
//MARK: INTERACTOR
/**
 interactor protocol
 */

protocol storable{
    var key:String{get set}
    
}

enum AnyInteactorState{
    case any
    case progress
    case success
    case fail
    
}


protocol AnyInteractor{
    var presenter:AnyPresenter?{get set}
    func loadData()
    func calculate(current:Int,target:Int,value:Double)
    func symbolforcurrency(Currency:currency)->String?
    
    
}
//MARK: PRESENTER
/**
 presnter contract
 
 */
protocol AnyPresenter{
    var router:AnyRouter{get set}
    var interactor:AnyInteractor{get set}
    var view:AnyView{get set}
    func loadData()
    func ondata(currencies:[currency])
    func onstate(state:AnyInteactorState)
    func oncalculation(result:currency)
    func calculate(current:Int,target:Int,value:Double)
    
}
//MARK: ROUTER
protocol AnyRouter{
    func navigate(route:String)
    func start()
    
}

//MARK: VIEW
protocol AnyView{
    var presenter:AnyPresenter?{get set}
    func setCalculationString(calculation:String)
    func setCurrencies(currencies:[String])
    func onstate(state:AnyInteactorState)
    
    
    
}








