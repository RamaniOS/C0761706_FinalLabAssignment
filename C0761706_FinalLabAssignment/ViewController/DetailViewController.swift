//
//  DetailViewController.swift
//  C0761706_FinalLabAssignment
//
//  Created by Ramanpreet Singh on 2020-01-24.
//  Copyright © 2020 Ramanpreet Singh. All rights reserved.
//

import UIKit

enum ControlType: String {
    case add = "Add Product", detail = "Detail Product"
}

class DetailViewController: AbstractViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    
    private var type: ControlType = .add
    private let persistenceManager = PersistenceManager.shared
    private var product: Product?
    
    class func control(With type: ControlType, and product: Product? = nil) -> DetailViewController {
        let control = self.control as! DetailViewController
        control.type = type
        control.product = product
        return control
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        title = type.rawValue
        Helper.applyGradient(to: saveButton)
        titleTextField.setBottomLine()
        priceTextField.setBottomLine()
        if let product = product { self.productValue = product }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        if !titleTextField.hasText {
            Helper.showAlert(with: "Please enter product name.", controller: self)
        } else if !priceTextField.hasText {
            Helper.showAlert(with: "Please enter price of product.", controller: self)
        } else if !descTextView.hasText {
            Helper.showAlert(with: "Please enter product desc.", controller: self)
        } else {
            var lastId = 0
            persistenceManager.fetch(type: Product.self) { (products) in
                for product in products {
                    if lastId < product.id {
                        lastId = Int(product.id)
                    }
                }
            }
            let product = Product(context: persistenceManager.context)
            product.id = Int16(lastId + 1)
            product.name = titleTextField.text!
            product.desc = descTextView.text!
            product.price = (priceTextField.text! as NSString).doubleValue
            // saving
            do {
                try persistenceManager.context.save()
                previousControl?.refresh()
                navigationController?.popViewController(animated: true)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    Helper.showAlert(with: "Product Saved Successfully.", controller: self)
                }
            } catch {
                Helper.showAlert(with: error.localizedDescription, controller: self)
            }
        }
    }
    
    // MARK: Get previous controller
    private var previousControl: HomeViewController? {
        let viewControls = navigationController?.viewControllers
        if let count = viewControls?.count, count >= 2 {
            let control = viewControls?[count - 2]
            if control is HomeViewController, let customer = control as? HomeViewController {
                return customer
            }
        }
        return nil
    }
    
    private var productValue: Product? {
        didSet {
            guard let product = product else { return }
            titleTextField.text = product.name
            priceTextField.text = "\(product.price)"
            descTextView.text = product.desc
            // make for details only
            titleTextField.isUserInteractionEnabled = false
            priceTextField.isUserInteractionEnabled = false
            descTextView.isUserInteractionEnabled = false
            saveButton.isHidden = true
        }
    }
}
