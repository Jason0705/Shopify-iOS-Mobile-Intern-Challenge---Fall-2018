//
//  ProvinceViewController.swift
//  Shopify iOS Mobile Intern Challenge
//
//  Created by Jason Li on 2018-07-14.
//  Copyright © 2018 Jason Li. All rights reserved.
//

import UIKit

class ProvinceViewController: UITableViewController {
    
    // Variable
    var sortedProvDict: [(key:String, value: [SummaryViewController.OrderData])] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
    // MARK: - Table view data source
    
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedProvDict.count
    }
    
    // Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedProvDict[section].value.count
    }
    
    // Cell for row at indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = sortedProvDict[indexPath.section].value[indexPath.row]
        cell.textLabel?.text = "Order: #\(cellData.orderNumber) | Price: $\(cellData.totalPrice) | Customer: \(cellData.customerName)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    // Did select row at indexPath
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: - Section Header
    
    // Title for header in section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedProvDict[section].key + " : \(sortedProvDict[section].value.count) Order(s)"
    }
    
    // height for header in section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    // Header view
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium);
        header.textLabel?.textColor = UIColor.white
        header.contentView.backgroundColor = UIColor(red:0.52, green:0.78, blue:0.25, alpha:1.0)
    }

}

