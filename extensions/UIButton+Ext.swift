//
//  UIButton+Ext.swift
//  Exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//


import UIKit

extension UIButton{
    
    func checkButton(){
        self.setImage(UIImage(named: "unselected_button"), for: .normal)
        self.setImage(UIImage(named: "selected_button"), for: .selected)
    }
   
}
