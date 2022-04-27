//
//  DKBottomSheetController.swift
//  Diyetkolik
//
//  Created by Deniz Karakurt on 13.02.2022.
//  Copyright © 2022 Deniz Karakurt. All rights reserved.
//

import UIKit

class DKBottomSheetController: UIPresentationController,UIGestureRecognizerDelegate,UIScrollViewDelegate{
    var height:CGFloat = 200
    var gesture:UIPanGestureRecognizer?
    var isTrackingPanLocation = false
    var viewTranslation = CGPoint(x: 0, y: 0)
    var dragBar:UIView!
    let max_size  = CGSize(width: 320, height: UIScreen.main.bounds.size.height * 0.6)
    var scrollView:UIScrollView?
    var scrollableOffset:CGPoint{
        get{
            if let scrollable = self.scrollView{
                //print(scrollable.contentOffset.y)
                return scrollable.contentOffset
            }
            return CGPoint(x: 0, y: 0)
        }
        
    }
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        let bounds = UIScreen.main.bounds
        dragBar = UIView(frame:CGRect(x:0,y:-20,width:bounds.width,height:30))
        dragBar.backgroundColor = .clear
      
        let drag = UIView(frame: CGRect(x:(bounds.width -  72)/2,y:8,width: 72,height: 4))
        drag.layer.cornerRadius = 2.5
        drag.backgroundColor = .clear
        dragBar.addSubview(drag)
        dragBar.layer.cornerRadius = 10
        
        self.presentedViewController.view.addSubview(dragBar)
        self.presentedViewController.view.clipsToBounds = false
        presentedViewController.view.layer.cornerRadius = 5
        
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
    
        if let view = presentedViewController.view {
            viewTranslation = sender.translation(in:view)
            if sender.state == .changed && (scrollableOffset.y == 0  || sender.view == self.dragBar){
                if viewTranslation.y > 0 {
                    view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                    dragBar?.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                }
            }else if sender.state == .cancelled || sender.state == .ended || sender.state == .failed {
               
                if viewTranslation.y < height / 2 {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        view.transform = .identity
                        self.dragBar?.transform = .identity
                    })
                    
                }else{
                    self.dragBar?.isHidden = true
                    self.presentingViewController.dismiss(animated: true, completion: nil)
                }
                
            }
            
        }
        
        
    }
   
    override var frameOfPresentedViewInContainerView: CGRect{
        let bounds = UIScreen.main.bounds
        self.containerView?.layer.shadowColor = UIColor.black.cgColor
        self.containerView?.layer.shadowOpacity = 0.1
        self.containerView?.layer.shadowRadius = 10
        self.containerView?.layer.shadowOffset = CGSize(width: 0, height: 10)
        let background = UIView(frame:bounds)
        background.backgroundColor = .black
        background.alpha = 0.1
        self.containerView?.addSubview(background)
        let targetRect  = CGRect(x: 10, y: bounds.height - height - 40, width: bounds.width - 20, height:height)
        
        self.gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
        self.presentedViewController.view?.addGestureRecognizer(gesture!)
        self.gesture?.delegate = self
        self.gesture?.isEnabled = true
        
        if let view = self.presentedViewController.view as? UIScrollView {
            /*view.rx.didScroll.subscribe { [weak self] event in
                if view.contentOffset.y <= 0  {
                    self?.gesture?.isEnabled = true
                    view.contentOffset = CGPoint(x: 0, y: 0)
                }
            }.disposed(by:bag )*/
            self.scrollView = view
            //self.scrollView?.bounces = false
            self.scrollView?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.scrollView?.isScrollEnabled = false
            //gesture = view.gestureRecognizers?.first(where:{$0 is UIPanGestureRecognizer}) as! UIPanGestureRecognizer
            
        }else{
            gesture?.isEnabled = true
            
            
        }
        return targetRect
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        if scrollView.contentOffset.y <= 0  {
            gesture?.isEnabled = true
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
        
        
        
    }
        
    override func presentationTransitionDidEnd(_ completed: Bool) {
       

        super.presentationTransitionDidEnd(completed)
        if let scrollView = scrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
        self.presentedViewController.view.clipsToBounds = true
        let bounds = UIScreen.main.bounds
        var frame = dragBar!.frame
        frame.origin.y = bounds.size.height - (height + 20)
        self.containerView?.addSubview(dragBar!)
        dragBar.frame = frame
        dragBar?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        self.scrollView?.isScrollEnabled = true
       
    }
    override func dismissalTransitionWillBegin() {
        self.dragBar.isHidden = true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
