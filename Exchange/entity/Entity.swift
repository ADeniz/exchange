//
//  Entity.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation





struct currency:Codable{
    let key:String
    let value:Double
    var symbol:String
    var localeString:String{
        get{
            if self.symbol.count > 0 {
                return "\(self.symbol) \(self.value.toFixedSizeLocaleString(len: 2))"
            }
            return "\(self.value.toFixedSizeLocaleString(len: 2)) \(self.key) "
        }
    }
}

struct CurrencyContainer:Codable,IStorable{
    static var key: String = "currencyrecord"
    
    func encoded() -> Data? {
        return getEncodedForType(type:self)
    }
    
    let result:String
    let documentation:String
    let terms_of_use:String
    let time_last_update_unix:Int
    let time_last_update_utc:String
    let time_next_update_unix:Int
    let time_next_update_utc:String
    let base_code:String
    let conversion_rates:[String:Double]
    func currencies(symbols:[String:String]?)->[currency]{
        return self.conversion_rates.map{
            let symbol:String!
            if let symbols = symbols{
                symbol = symbols[$0.key] ?? ""
            }else{
                symbol = ""
            }
            return currency(key:$0.key,value: $0.value,symbol:symbol)
            
        }.sorted(by:{$0.key < $1.key})
    }
    var update_date:Date{
        get{
            return  Date.init(timeIntervalSince1970: TimeInterval(self.time_next_update_unix))
        }
    }
    var is_up_to_date:Bool{
        get{
            let nextupdate = Date.init(timeIntervalSince1970: TimeInterval(self.time_next_update_unix))
            
            return nextupdate > Date()
        }
    }
    
}
struct Calculation{
    let current:currency
    let target:currency
    let rate:Double
}
