//
//  TodoCell.swift
//  C0761706_LabAssignment2
//
//  Created by Ramanpreet Singh on 2020-01-19.
//  Copyright © 2020 Ramanpreet Singh. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    class var reuseId: String {
        return String(describing: self)
    }
    
    var product: Product? {
        didSet {
            if let product = product {
                titleLabel.text = product.name
                priceLabel.text = "Price: \("\(product.price)".toDollar)" 
                descLabel.text = product.desc
            }
        }
    }
}
