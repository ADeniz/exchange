//
//  DKBottomSheetDelegate.swift
//  Diyetkolik
//
//  Created by Deniz Karakurt on 13.02.2022.
//  Copyright © 2022 Deniz Karakurt. All rights reserved.
//

import Foundation
import UIKit
class DKBottomSheetDelegate:NSObject,UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DKBottomSheetController(presentedViewController: presented, presenting: presenting)
    }
    
    
}
