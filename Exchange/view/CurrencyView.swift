//
//  CurrencyView.swift
//  Exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import UIKit

final class CurrencyView:UIViewController,currencyListerView,UITableViewDelegate,UITableViewDataSource,currencySelectionDelegateProvider,routedview{
   
    
    
    
   
   
    
    
    

    @IBOutlet weak var close:UIBarButtonItem?
    @IBOutlet weak var tableView:UITableView?
    var presenter: AnyPresenter?
    var currencies:[String] = []
    static var identifier: String!{
        get{
            return "CurrencyView"
        }
    }
    var delegate:currencySelectionDelegate?
    func setCurrencies(currencies: [String]) {
        self.currencies = currencies
        self.tableView?.reloadData()
    }
    
    @IBAction func close_self(){
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.close?.action = #selector(close_self)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currency_cell") ?? UITableViewCell()
        
        if let cell = cell as? CurrencyCellView {
            cell.title_label.text = currencies[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CurrencyCellView{
            cell.checkButton?.isSelected = true
            delegate?.currencySelected(index: indexPath.row)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
   
   
 
    
    
    
}
