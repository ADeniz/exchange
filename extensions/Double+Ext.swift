//
//  Double+Ext.swift
//  exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import Foundation
extension Double {
    func toIntString()->String{
        return String.init(format:"%.0f",arguments:[self as CVarArg])
    }
    func toFixedSizeLocaleString(len:Int=2)->String{
        return String.init(format: "%.\(len)f", locale: Locale.current,arguments:[self as CVarArg])
    }
    
    func toFixedSizeLocaleStringIfNedded(len:Int=2)->String{
       if self.isNaN {
            
            return ""
        }else{
            
            return Double( floor(self)) < self ? self.toFixedSizeLocaleString(len:len) : toFixedSizeLocaleString(len:0)
        }
        
    }
    
}

extension String{
    func thousendSep()->String{
       
        if let num = Double(self.replacingOccurrences(of: Locale.current.groupingSeparator ?? "", with:"")){
            return num.toFixedSizeLocaleStringIfNedded(len: 2)
        }
        return self
    }
    func toDouble()->Double{
        return Double(self.replacingOccurrences(of: Locale.current.groupingSeparator ?? "", with:"")) ?? 0
    }
}
