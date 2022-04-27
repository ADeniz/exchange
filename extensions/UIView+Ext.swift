//
//  UIView+Ext.swift
//  Exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import Foundation
import UIKit
extension UIView{
    func dropShadow(){
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: -1, height: 2)
        layer.shadowRadius = 3

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = 1
    }
}
