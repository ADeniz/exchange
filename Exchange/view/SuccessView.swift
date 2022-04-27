//
//  SuccessView.swift
//  Exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import UIKit

class SuccessView:UIViewController,SuccesViewProtocol,routedview{
    
    
   
    
    @IBOutlet weak var success_mesage_field:UILabel?
    var presenter: AnyPresenter?
    
    static var identifier: String!{
        get{
            return "success"
        }
    }
    @IBAction func close(){
        self.presenter?.close()
    }
    func success(message: NSAttributedString) {
        self.success_mesage_field?.attributedText = message
    }
    
   
    
    
}
