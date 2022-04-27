//
//  UserDefaults+Ext.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation

extension UserDefaults{
    var currencies:CurrencyContainer?{
        get{
            guard let data = self.data(forKey: CurrencyContainer.key) else{
                return nil
            }
            return CurrencyContainer.sample(type:CurrencyContainer.self, data: data)
        }
        set{
            if let data  = newValue?.encoded(){
                self.setValue(data, forKey: CurrencyContainer.key)
            }
            
        }
    }
}
