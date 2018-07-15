//
//  SummaryViewController.swift
//  Shopify iOS Mobile Intern Challenge
//
//  Created by Jason Li on 2018-07-14.
//  Copyright © 2018 Jason Li. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SummaryViewController: UIViewController {
    
    let orderDataModel = OrderDataModel()
    
    
    var orderDict: [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)] = []
    var groupedProvDict = [String : [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)]]()
    var groupedYearDict = [String : [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)]]()
    var sortedProvDict: [(key:String, value: [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)])] = []
    var firstTen2017Orders: [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)] = []
    
    
    @IBOutlet weak var provinceView: UIView!
    @IBOutlet weak var yearView: UIView!
    
    @IBOutlet weak var provinceTableView: UITableView!
    @IBOutlet weak var yearTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provinceTableView.delegate = self
        provinceTableView.dataSource = self
        
        yearTableView.delegate = self
        yearTableView.dataSource = self
        
        getOrderData()
    }
    
    
    
    // MARK: - Networking
    
    // getOrderData Method
    func getOrderData() {
        
        Alamofire.request("https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6", method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                let orderJSON : JSON = JSON(response.result.value!)
                self.createOrderDict(with: orderJSON)
            } else {
                print("Couldnt process JSON response, Error: \(response.result.error)")
            }
        }
    }
    
    
    // MARK: - JSON Parsing
    
    
    func createOrderDict(with json: JSON) {
        guard !json.isEmpty else {fatalError("json unavailible!")}
        
        var customer = ""
        var province = ""
        
        for order in json["orders"].arrayValue {
            orderDataModel.province = order["shipping_address"]["province"].stringValue
            orderDataModel.orderYear = String(order["created_at"].stringValue.prefix(4))
            orderDataModel.orderNumber = order["order_number"].stringValue
            orderDataModel.totalPrice = order["total_price"].stringValue
            orderDataModel.customerName = order["shipping_address"]["name"].stringValue
            
            // Check if province is empty
            if orderDataModel.province != "" {
                province = orderDataModel.province
            } else {
                province = "Missing Data"
            }
            
            // Check if customerName is empty
            if orderDataModel.customerName != "" {
                customer = orderDataModel.customerName
            } else {
                customer = "Name Unavailible"
            }
            
            let newElement = (orderProvince: province, orderYear: orderDataModel.orderYear, orderNumber: orderDataModel.orderNumber, totalPrice: orderDataModel.totalPrice, customerName: customer)
            
            orderDict.append(newElement)
            
        }
        
        groupByProvince()
        groupByYear()
        sortProvinces()
        getFirstTen2017Orders()
        
        provinceTableView.reloadData()
        yearTableView.reloadData()
    }
    
    
    func groupByProvince() {
        groupedProvDict = Dictionary(grouping: orderDict) { $0.orderProvince }
    }
    
    func groupByYear() {
        groupedYearDict = Dictionary(grouping: orderDict) { $0.orderYear }
    }
    
    func sortProvinces() {
        sortedProvDict = groupedProvDict.sorted(by: { $0.0 < $1.0 })
    }
    
    func getFirstTen2017Orders() {
        var ordersOf2017 = groupedYearDict["2017"]!
        if ordersOf2017.count > 10 {
            let slice = ordersOf2017.prefix(10)
            firstTen2017Orders = Array(slice)
        } else {
            firstTen2017Orders = ordersOf2017
        }
    }
    

    
    @IBAction func orderByProvinceButtonPressed(_ sender: UIButton) {
    }
    
}





//MARK: - TableView Datasource Methods

extension SummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.provinceTableView {
            return sortedProvDict.count
        }
        else if tableView == self.yearTableView {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.provinceTableView {
            return 1
        }
        else if tableView == self.yearTableView {
            return firstTen2017Orders.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if tableView == self.provinceTableView {
            cell = provinceTableView.dequeueReusableCell(withIdentifier: "provinceCell", for: indexPath)
            let cellData = sortedProvDict[indexPath.section]
            cell.textLabel?.text = "\(cellData.value.count) orders in \(cellData.key)"
            return cell
        }
        else if tableView == self.yearTableView {
            cell = yearTableView.dequeueReusableCell(withIdentifier: "yearCell", for: indexPath)
            let cellData = firstTen2017Orders[indexPath.row]
            cell.textLabel?.text = "Order: #\(cellData.orderNumber) | Price: $\(cellData.totalPrice) | Customer: \(cellData.customerName)"
            cell.textLabel?.numberOfLines = 0
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Section Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.provinceTableView {
            return sortedProvDict[section].key
        }
        else if tableView == self.yearTableView {
            return "2017 : \(firstTen2017Orders.count) Orders"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41.5
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium);
        header.textLabel?.textColor = UIColor.white
        header.contentView.backgroundColor = UIColor(red:0.52, green:0.78, blue:0.25, alpha:1.0)
    }
    
}
