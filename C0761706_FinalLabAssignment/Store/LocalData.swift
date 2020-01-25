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
        for index in  1...10 {
            let product1 = Product(context: coreDataContext)
            product1.id = Int16(index)
            product1.name = "Product\(index)"
            product1.desc = "Product\(index) description here"
            product1.price = 100 * Double(index)
            do {
                try coreDataContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
