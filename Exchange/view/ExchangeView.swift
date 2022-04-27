//
//  view.swift
//  exchange
//
//  Created by Deniz Karakurt on 26.04.2022.
//

import Foundation
import UIKit

class ExchangeView:UIViewController,AnyView,UITextFieldDelegate,UIViewControllerTransitioningDelegate,currencySelectionDelegate,routedview{
   
    static var identifier: String! = "ExchangeView"
    var presenter: AnyPresenter?
    @IBOutlet weak var current:ProgressButton?
    @IBOutlet weak var target:ProgressButton?
    @IBOutlet weak var value_field:UITextField?
    @IBOutlet weak var value_inputAccessoryView: UIView?
    @IBOutlet weak var final_amount_field:UILabel?
    @IBOutlet weak var currency_values_field:UILabel?
    @IBOutlet weak var excahnge_button:UIButton?
    lazy var closeButton:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(close_keyboard))
    var tempString:String?
    var currencies:[String] = []
    var indexes:[Int] = [-1,-1]
    var selectedIndex:Int = 0
    @IBAction func selectCurrency(target:UIButton){
        selectedIndex = target.tag
        if let currency_selector = CurrencyView.newInstance(identifier:CurrencyView.identifier) as? CurrencyView{
            currency_selector.setCurrencies(currencies: self.currencies)
            currency_selector.delegate  = self
            currency_selector.modalPresentationStyle = .pageSheet
            if let sheet = currency_selector.sheetPresentationController{
                sheet.detents = [.medium()]
            }
            present(currency_selector, animated: true, completion: nil)
        }
        
    }
    @IBAction func cross_index(){
        indexes.reverse()
        current?.value = currencies[indexes[0]]
        target?.value = currencies[indexes[1]]
        calculate()
    }
    @objc func close_keyboard(){
        self.value_field?.resignFirstResponder()
        if let tempString = tempString , self.value_field?.text?.count == 0 {
            self.value_field?.text = tempString
            self.tempString = nil
        }
    }
    func setCalculationString(calculation: NSAttributedString,rate:Double) {
        final_amount_field?.attributedText = calculation
        currency_values_field?.text = "1 \(currencies[indexes[0]]) = \(rate.toFixedSizeLocaleString(len: 2)) \(currencies[indexes[1]])"
    }
    
    func setCurrencies(currencies: [String]) {
        self.current?.stopProgress()
        self.target?.stopProgress()
        self.currencies = currencies
        indexes = [0,1]
        self.current?.value = currencies[0]
        self.target?.value = currencies[1]
        self.calculate()
    }
    
    func onstate(state: AnyInteactorState) {
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor(named:"primary")
        self.value_inputAccessoryView?.removeFromSuperview()
        textField.inputAccessoryView = self.value_inputAccessoryView
        self.tempString = textField.text
        textField.text = ""
        self.navigationItem.rightBarButtonItem = self.closeButton
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.navigationItem.rightBarButtonItem = nil
        if let value_inputAccessoryView = value_inputAccessoryView {
            self.view.addSubview(value_inputAccessoryView)
            value_inputAccessoryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            value_inputAccessoryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            value_inputAccessoryView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.calculate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.excahnge_button?.alpha = 0.7
        self.excahnge_button?.isEnabled  = false
        self.value_field?.delegate = self
        self.navigationItem.title = "Exchange"
        self.currency_values_field?.layer.borderColor = UIColor(named:"textColor")?.cgColor ?? UIColor.lightGray.cgColor
        self.currency_values_field?.layer.borderWidth = 1
        self.value_inputAccessoryView?.dropShadow()
        self.value_inputAccessoryView?.translatesAutoresizingMaskIntoConstraints = false
        self.current?.progress()
        self.target?.progress()
        presenter?.loadData()
    }
    
    func calculate(){
        if indexes.filter({$0 == -1}).count == 0 {
            if let text = self.value_field?.text{
                if let value = Double(text){
                    self.excahnge_button?.isEnabled  = value > 0
                    self.excahnge_button?.alpha = value > 0 ? 1 : 0.7
                    presenter?.calculate(current: indexes[0], target: indexes[1], value: value)
                }
               
            }
           
        }else{
            self.excahnge_button?.isEnabled  = false
            self.excahnge_button?.alpha = 0.7
        }
    }
    func confirm(message: NSAttributedString) {
        self.close_keyboard()
        let alert = UIAlertController(title: "Confirm Operation", message:"kk", preferredStyle: .alert)
        alert.setValue(message, forKey: "attributedMessage")
        alert.addAction(UIAlertAction.init(title:"Cancel", style: .cancel, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction.init(title:"Confirm", style: .default, handler: {[weak self] _ in
            if let value = Double(self?.value_field?.text ?? ""),let current = self?.indexes[0],let target = self?.indexes[1]{
                self?.presenter?.exchange(current:current , target:target, value: value)
            }
        }))
        present(alert, animated: true, completion: nil)
        
    }
    @IBAction func exchange(){
        if let value = Double(self.value_field?.text ?? ""){
            presenter?.needConfirm(current: indexes[0], target: indexes[1], value: value)
        }
        
    }
    func currencySelected(index: Int) {
        indexes[selectedIndex] = index
        let button = selectedIndex == 0 ? current : target
        button?.value = currencies[index]
        calculate()
    }
    
   
    
    
    
}
