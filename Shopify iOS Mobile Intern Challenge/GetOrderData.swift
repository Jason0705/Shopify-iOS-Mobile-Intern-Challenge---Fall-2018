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
    
    var data : JSON = []
    
    
    // MARK: - Networking
    
    // getOrderData Method
    func getOrderData() {
        Alamofire.request("https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6", method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                let orderJSON : JSON = JSON(response.result.value!)
                self.data = orderJSON
                print(orderJSON)
            } else {
                print("Couldnt process JSON response, Error: \(response.result.error)")
            }
        }
    }
    
    
    // MARK: - JSON Parsing
    
    
    
}
