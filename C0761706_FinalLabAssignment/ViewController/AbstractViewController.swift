//
//  AbstractViewController.swift
//  C0761706_FinalLabAssignment
//
//  Created by Ramanpreet Singh on 2020-01-24.
//  Copyright © 2020 Ramanpreet Singh. All rights reserved.
//

import UIKit

class AbstractViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class var control: AbstractViewController {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! AbstractViewController
    }
}

