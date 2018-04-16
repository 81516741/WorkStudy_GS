//
//  Tool.swift
//  iMTC-Swift
//
//  Created by ld on 2018/1/2.
//  Copyright © 2018年 ld. All rights reserved.
//

import UIKit

class Tool: NSObject {
    // MARK:单例
    static let shared: Tool = {
        let instance = Tool()
        return instance
    }()
    private override init(){}
    
    var loginModel:LoginModel?
    
    class func configRootViewController() {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        Tool.appdelegate().window = window
        
        if let _ = Tool.shared.loginModel {
            Tool.showLoginVC()
        } else {
            Tool.showLoginVC()
        }
        
        Tool.window().makeKeyAndVisible()
    }
    
    class func showLoginVC() {
        Tool.window().rootViewController = BaseNavigationVC.init(rootViewController: Tool.loginStoryboardVC(identifier: "LoginVC"))
    }
    
    class func loginStoryboardVC(identifier id:String) -> UIViewController{
        let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: id)
        return vc
    }
    
    class func appdelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    class func window() -> UIWindow {
        return Tool.appdelegate().window!;
    }
}


