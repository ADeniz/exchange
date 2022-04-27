//
//  UIViewController.swift
//  Exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import UIKit

extension UIViewController{
   
    
    
    static func newInstance(identifier:String)->UIViewController?{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: identifier) 
        return view
       
    }
}
