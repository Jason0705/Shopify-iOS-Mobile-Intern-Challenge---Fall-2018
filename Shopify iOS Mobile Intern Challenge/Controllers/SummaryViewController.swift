//
//  SummaryViewController.swift
//  Shopify iOS Mobile Intern Challenge
//
//  Created by Jason Li on 2018-07-14.
//  Copyright © 2018 Jason Li. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    
    @IBOutlet weak var provinceView: UIView!
    @IBOutlet weak var yearView: UIView!
    
    @IBOutlet weak var provinceTableView: UITableView!
    @IBOutlet weak var yearTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func orderByProvinceButtonPressed(_ sender: UIButton) {
    }
    
    
}
