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

protocol currencySelectionDelegate{
    func currencySelected(index:Int)
}
protocol currencySelectionDelegateProvider{
    var delegate:currencySelectionDelegate?{get set}
}

protocol routedview:UIViewController{
    static var identifier:String!{get}
}

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
    var successview:SuccesViewProtocol?{get set}
    func loadData()
    func ondata(currencies:[currency])
    func onstate(state:AnyInteactorState)
    func oncalculation(calculation:Calculation)
    func calculate(current:Int,target:Int,value:Double)
    func openListMenu()
    func exchange(current:Int,target:Int,value:Double)
    func needConfirm(current:Int,target:Int,value:Double)
    func close()
    
}
//MARK: ROUTER

enum AnyRoute:String{
    
    case success = "success"
    
}
protocol AnyRouter{
    var view:routedview{get set}
    func navigate(route:AnyRoute)
    func pop()
    func start()
    
}

//MARK: VIEW




protocol currencyListerView:UIViewController{
    func setCurrencies(currencies:[String])
}


protocol presentedViewProtocol:UIViewController{
    var presenter:AnyPresenter?{get set}
}

protocol AnyView:currencyListerView,presentedViewProtocol{
    func setCalculationString(calculation:NSAttributedString,rate:Double)
    func onstate(state:AnyInteactorState)
    func confirm(message:NSAttributedString)
    
}

protocol SuccesViewProtocol:presentedViewProtocol{
    func success(message:NSAttributedString)
    
}







