//
//  ProvinceViewController.swift
//  Shopify iOS Mobile Intern Challenge
//
//  Created by Jason Li on 2018-07-14.
//  Copyright © 2018 Jason Li. All rights reserved.
//

import UIKit

class ProvinceViewController: UITableViewController {
    
    var sortedProvDict: [(key:String, value: [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)])] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedProvDict.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedProvDict[section].value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = sortedProvDict[indexPath.section].value[indexPath.row]
        cell.textLabel?.text = "Order: #\(cellData.orderNumber) | Price: $\(cellData.totalPrice) | Customer: \(cellData.customerName)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
    //MARK: - Section Header
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedProvDict[section].key + " : \(sortedProvDict[section].value.count) Order(s)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41.5
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium);
        header.textLabel?.textColor = UIColor.white
        header.contentView.backgroundColor = UIColor(red:0.52, green:0.78, blue:0.25, alpha:1.0)
    }

}

