//
//  LoginVC.swift
//  iMTC-Swift
//
//  Created by ld on 2018/1/2.
//  Copyright © 2018年 ld. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
}
