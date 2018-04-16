//
//  TextfieldBehavior.swift
//  iMTC-Swift
//
//  Created by ld on 2018/1/2.
//  Copyright © 2018年 ld. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TextfieldBehavior: Behavior {
    
    @IBInspectable open var length:String? {
        didSet {
            self.checkSelArr.add(NSStringFromSelector(#selector(checkLength)))
        }
    }
    @IBInspectable open var minLength:String? {
        didSet {
            self.checkSelArr.add(NSStringFromSelector(#selector(checkMinLength)))
        }
    }
    
    
   @IBOutlet var textField:UITextField! {
        didSet {
            if !textField.isKind(of: NSClassFromString("UITextField")!)
            {
                return
            }
            weak var weakSelf = self
            
//            textField.reactive.signal(forKeyPath: "text").observe { (obj) in
//                
//                let _ = weakSelf?.check()
//            }
        textField.reactive.controlEvents(.editingChanged).observe { (obj) in
            let _ = weakSelf?.check()
            }

        }
    }
    
    lazy var checkSelArr = NSMutableArray.init()

    @objc func checkLength() -> String {
        let str = NSString.init(string: textField.text!)
        if let tempLength = Int(length!)  {
            if str.length > tempLength {
                textField.text = str.substring(to: tempLength)
                return "true"
            }
        }
        
        
        if str.length == Int(length!) {
            return "true"
        }
        
        return "false";
    }
    @objc func checkMinLength()->String {
        let str = textField.text!
        if let tempLength = Int(minLength!) {
            if (str.count >= tempLength) {
                return "true";
            }
        }
        return "false"
    }

    
    override func check() -> Bool {
        var state = true
        for obj in self.checkSelArr {
            let result =
                perform(NSSelectorFromString(obj as! String), with: textField).retain().takeUnretainedValue()
            if result.isEqual(to: "false") {
                state = false
                break
            }
        }
        return state
    }

}
