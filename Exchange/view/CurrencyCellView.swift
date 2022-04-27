//
//  CurrencyCellView.swift
//  Exchange
//
//  Created by Deniz Karakurt on 27.04.2022.
//

import UIKit

class CurrencyCellView:UITableViewCell{
    @IBOutlet weak var title_label:UILabel!
    @IBOutlet weak var checkButton:UIButton?
    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.checkButton?.checkButton()
    }
}
