//
//  IStorable+Ext.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation
extension IStorable {
    /**
     this static method convert to data  which instances are  IStorable implemented codables
     -   parameter type : type of instance which is  IStorable implemented
     */
    static func getEncodedForType<T:Codable>(type:T)->Data?{
        let encoder = JSONEncoder()
        guard let _encoded = try? encoder.encode(type.self) else {
            return nil
        }
        
        return _encoded
    }
    
    static func sample<T:Codable>(type:T.Type,data:Data)->T?{
        
        let Decoder = JSONDecoder()
        //Decoder.keyDecodingStrategy = .convertFromSnakeCase
        Decoder.dateDecodingStrategy = .secondsSince1970
        if let decoded = try? Decoder.decode(type.self, from: data){
            print(decoded)
            return decoded
        }else{
            print("hata")
        }
        
        return nil
    }
    /**
     this  method convert to data  which instances are  IStorable implemented codables
     -   parameter type : type of instance which is  IStorable implemented
     */
    func getEncodedForType<T:Codable>(type:T)->Data?{
        let encoder = JSONEncoder()
        guard let _encoded = try? encoder.encode(type.self) else {
            return nil
        }
        
        return _encoded
    }
    
}
