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
            return Double( Int(self)) < self ? self.toFixedSizeLocaleString(len:len) : self.toIntString()
        }
        
    }
}
