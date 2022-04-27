//
//  API.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation

enum APIError: Error {
   
    case unknowned

    case notFound
    
    case invalid_data
    
    case unexpected(code: Int)
    
}

class API{
    
    let host:String  =  "https://v6.exchangerate-api.com/v6/8dbe6d61507615ea3df025d7"
    private static var _current:API?
    static var shared:API{
        get{
            if let _current = API._current {
                return _current
            }
            API._current = API()
            return API._current!
        }
    }
   
    func request(method:String,data:Data?,success: @escaping(Data)->Void,fail:@escaping(Error)->Void)->URLSessionDataTask?{
        guard let url = URL(string:self.host+method) else{
            return nil
        }
        var request = URLRequest(url: url)
        if let data = data {
            request.httpMethod = "POST"
            request.httpBody = data
        }else{
            request.httpMethod = "GET"
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { response_data, url_response, error in
            if let error = error  {
                fail(error)
                return
            }
            guard let response_data = response_data else {
                fail(APIError.unknowned)
                return
            }
            success(response_data)

        }
        task.resume()
        return task
    }
    func decoder<T:Codable>(type:T.Type,data:Data)->T?{
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data)else{
            return nil
        }
        return decoded
    }
    func latestUSD(success: @escaping(CurrencyContainer)->Void,fail:@escaping(Error)->Void){
        _ = self.request(method: "/latest/USD", data: nil) {[weak self] data in
            if let _self = self{
                guard let container = _self.decoder(type: CurrencyContainer.self, data: data) else{
                    fail(APIError.invalid_data)
                    return
                }
                success(container)
                 
            }
        } fail: { error in
            fail(error)
        }

    }
   
    

    
}
