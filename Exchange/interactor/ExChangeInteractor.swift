//
//  interactor.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation
class ExchangeInteractor:AnyInteractor{
    var presenter: AnyPresenter?
    var currencies:[currency]?
    var update_date:Date?
    func loadData() {
        self.loadData(complete: nil)

    }
    func loadData(complete:(()->Void)?){
        self.presenter?.onstate(state: .progress)
        let symbols = self.symbolsforcurrencies()
        if let currencyContainer = UserDefaults.standard.currencies {
            if currencyContainer.is_up_to_date {
                self.currencies = currencyContainer.currencies(symbols:symbols)
                self.presenter?.onstate(state: .success)
                self.update_date = currencyContainer.update_date
                if let complete = complete {
                    complete()
                }else{
                    self.presenter?.ondata(currencies: currencyContainer.currencies(symbols:symbols))
                }
                return
            }
        }
        API.shared.latestUSD {[weak self] container in
           
            let symbols = self?.symbolsforcurrencies()
            
            UserDefaults.standard.currencies = container
            self?.update_date = container.update_date
            let currencies = container.currencies(symbols:symbols)
            self?.currencies  = currencies
            self?.presenter?.ondata(currencies:currencies)
            self?.presenter?.onstate(state: .success)
            if let complete = complete {
                complete()
            }
        } fail: {[weak self] error in
            self?.presenter?.onstate(state: .fail)
        }
    }
    func operation(complete:@escaping()->Void){
        if let update_date = update_date{
            if update_date > Date(){
                complete()
            }
        }else{
            loadData(complete: complete)
        }
    }
    func calculate(current:currency,target:currency,value:Double)->Calculation{
        let _calculation = target.value / current.value * value
        let rate =  target.value / current.value
        let newtarget = currency(key: target.key, value: _calculation, symbol: target.symbol)
        let newcurrent = currency(key: current.key, value: value, symbol: current.symbol)
        return Calculation.init(current:newcurrent,target:newtarget,rate:rate)
    }
    func calculate(current: Int, target: Int, value: Double) {
        
        self.operation {
            if let currencies = self.currencies {
                let _current  = currencies[current]
                let _target = currencies[target]
                let calculation = self.calculate(current: _current, target: _target, value: value)
                DispatchQueue.main.async {
                    self.presenter?.oncalculation(calculation: calculation)
                }
            }
        }
    }
    func symbolsforcurrencies()->[String:String]?{
        guard let url = Bundle.main.url(forResource: "currencySymbols", withExtension:"json")else{
            return nil
        }
        guard let data = try? JSONSerialization.jsonObject(with: Data.init(contentsOf: url, options: .alwaysMapped), options: .fragmentsAllowed)else{
            return nil
        }
        guard let data = data as? [String:String] else{
            return nil
        }
        return data
        
       
    }
    func symbolforcurrency(Currency:currency)->String?{
        guard let url = Bundle.main.url(forResource: "currencySymbols", withExtension:"json")else{
            return nil
        }
        guard let data = try? JSONSerialization.jsonObject(with: Data.init(contentsOf: url, options: .alwaysMapped), options: .fragmentsAllowed)else{
            return nil
        }
        guard let data = data as? [String:String] else{
            return nil
        }
        return data[Currency.key]
        
       
    }
    
}

