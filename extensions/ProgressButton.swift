//
//  TemplateButton.swift
//  Exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import Foundation
import UIKit

class ProgressButton:UIButton{
    var tempTitle:String?
    var tempImage:UIImage?
    lazy var preloader = UIActivityIndicatorView.init(style: .medium)
    
    var value:String?{
        didSet{
            DispatchQueue.main.async {
                self.setTitle(self.value, for: .normal)
            }
        }
    }
    func progress(){
        self.tempTitle = self.title(for: .normal)
        self.tempImage = self.image(for: .normal)
        self.setTitle("", for: .normal)
        self.setImage(nil, for: .normal)
        self.addSubview(preloader)
        preloader.translatesAutoresizingMaskIntoConstraints = false
        preloader.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 5).isActive = true
        preloader.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        preloader.startAnimating()
        preloader.hidesWhenStopped = true
    }
    func stopProgress(){
        
            DispatchQueue.main.async {
                if self.preloader.superview != nil{
                    self.preloader.stopAnimating()
                    self.setTitle(self.tempTitle, for: .normal)
                    self.setImage(self.tempImage, for: .normal)
                }
            }
        
        
    }
}
