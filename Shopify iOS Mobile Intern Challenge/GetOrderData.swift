//
//  GetOrderData.swift
//  Shopify iOS Mobile Intern Challenge
//
//  Created by Jason Li on 2018-07-14.
//  Copyright © 2018 Jason Li. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GetOrderData {
    
    let orderDataModel = OrderDataModel()
    
    
    var orderDict: [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)] = []
    var groupedProvDict = [String : [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)]]()
    var groupedYearDict = [String : [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)]]()
    var sortedProvDict: [(key:String, value: [(orderProvince: String, orderYear: String, orderNumber: String, totalPrice: String, customerName: String)])] = []
    
    
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
    
}
