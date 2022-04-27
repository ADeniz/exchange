//
//  CheckButton.swift
//  Exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import UIKit

class CheckButton: UIButton {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setTheme(){
        self.layer.cornerRadius = 20
        self.setImage(<#T##image: UIImage?##UIImage?#>, for: .selected)
    }

}
