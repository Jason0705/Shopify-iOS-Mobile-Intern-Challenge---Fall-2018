//
//  SummaryViewController.swift
//  Shopify iOS Mobile Intern Challenge
//
//  Created by Jason Li on 2018-07-14.
//  Copyright © 2018 Jason Li. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    let getOrderData = GetOrderData()
    
    
    var groupedProvDict = [String : [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)]]()
    var groupedYearDict = [String : [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)]]()
    
    
    @IBOutlet weak var provinceView: UIView!
    @IBOutlet weak var yearView: UIView!
    
    @IBOutlet weak var provinceTableView: UITableView!
    @IBOutlet weak var yearTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOrderData.getOrderData()
        //groupByProvince()
        //print(getOrderData.orderDict)
        //print(groupedProvDict)
    }
    
    
    func groupByProvince() {
        groupedProvDict = Dictionary(grouping: getOrderData.orderDict) { $0.orderProvince }
    }
    
    func groupByYear() {
        groupedYearDict = Dictionary(grouping: getOrderData.orderDict) { $0.orderYear }
    }

    
    @IBAction func orderByProvinceButtonPressed(_ sender: UIButton) {
    }
    
    
}

