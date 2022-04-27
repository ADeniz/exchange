//
//  DKBottomSheetSegue.swift
//  Diyetkolik
//
//  Created by Deniz Karakurt on 15.02.2022.
//  Copyright © 2022 Deniz Karakurt. All rights reserved.
//

import Foundation
import UIKit

class DKBottomSheetSegue:UIStoryboardSegue,UIViewControllerTransitioningDelegate{
    
    override func perform() {
        self.destination.modalPresentationStyle = .custom
        self.destination.transitioningDelegate = self
        self.source.present(self.destination, animated: true, completion:nil)
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presenter = DKBottomSheetController(presentedViewController: presented, presenting: presenting)
        if let identifier = self.identifier{
            let parts = identifier.split(separator:"_")
            if parts.count > 1 {
                let h = Double(parts[1])
                presenter.height = CGFloat(h!)
                if #available(iOS 11.0, *) {
                    
                     
                     // ...
                }
            }
            return presenter
        }
        if let heightProvider = presented as? DKModalHeightProvider{
            presenter.height = heightProvider.needHeightForModal
            if #available(iOS 11.0, *) {
               
            }
        }
        return presenter
    }
}
