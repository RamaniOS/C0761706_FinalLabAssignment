//
//  LocalData.swift
//  C0761706_FinalLabAssignment
//
//  Created by Ramanpreet Singh on 2020-01-24.
//  Copyright © 2020 Ramanpreet Singh. All rights reserved.
//

import Foundation

struct LocalData {
    
    private init() {}
    
    private static let isFirstLaunchKey = "isFirstLaunchKey"
    
    public static var isFirstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isFirstLaunchKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isFirstLaunchKey)
        }
    }
    
    private static let coreDataContext = PersistenceManager.shared.context
    
    static func initItems() {
        // product 1
        let product1 = Product(context: coreDataContext)
        product1.id = 1
        product1.name = "Product1"
        product1.desc = "Product1 description here"
        product1.price = 100.30
        // product 2
        let product2 = Product(context: coreDataContext)
        product2.id = 2
        product2.name = "Product2"
        product2.desc = "Product2 description here"
        product2.price = 200.30
        // product 3
        let product3 = Product(context: coreDataContext)
        product3.id = 3
        product3.name = "Product3"
        product3.desc = "Product3 description here"
        product3.price = 300.30
        // product 4
        let product4 = Product(context: coreDataContext)
        product4.id = 4
        product4.name = "Product4"
        product4.desc = "Product4 description here"
        product4.price = 400.30
        // product 5
        let product5 = Product(context: coreDataContext)
        product5.id = 5
        product5.name = "Product5"
        product5.desc = "Product5 description here"
        product5.price = 500.30
        // product 6
        let product6 = Product(context: coreDataContext)
        product6.id = 6
        product6.name = "Product6"
        product6.desc = "Product6 description here"
        product6.price = 600.30
        // product 7
        let product7 = Product(context: coreDataContext)
        product7.id = 7
        product7.name = "Product7"
        product7.desc = "Product7 description here"
        product7.price = 700.30
        // product 8
        let product8 = Product(context: coreDataContext)
        product8.id = 8
        product8.name = "Product8"
        product8.desc = "Product8 description here"
        product8.price = 800.30
        // product 9
        let product9 = Product(context: coreDataContext)
        product9.id = 9
        product9.name = "Product9"
        product9.desc = "Product9 description here"
        product9.price = 900.30
        // product 10
        let product10 = Product(context: coreDataContext)
        product10.id = 10
        product10.name = "Product10"
        product10.desc = "Product10 description here"
        product10.price = 1000.30
        // saving
        do {
            try coreDataContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
