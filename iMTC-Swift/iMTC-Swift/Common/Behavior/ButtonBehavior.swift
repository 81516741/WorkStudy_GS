//
//  ButtonBehavior.swift
//  iMTC-Swift
//
//  Created by ld on 2018/1/3.
//  Copyright © 2018年 ld. All rights reserved.
//

import UIKit

class ButtonBehavior: Behavior {
    
    @IBInspectable var normalColor : UIColor?
    @IBInspectable var disableColor : UIColor?
    
    @IBOutlet var behaviors: [Behavior]!
    @IBOutlet var btn : UIButton!
    
    var initSubBehaviorCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        observe()
        btnCheck()
    }
   
    func observe() {
        for item in behaviors {
            if item.isKind(of: TextfieldBehavior.classForCoder()) {
                let itemReal = item as! TextfieldBehavior
                itemReal.reactive.signal(forKeyPath: "textField").observe
                    { (obj) in
//                    itemReal.textField.reactive.signal(forKeyPath: "text").observe { (obj) in
//                        let _ = self.check()
//                        }
                    
                    itemReal.textField.reactive.controlEvents(.editingChanged).observe { (obj) in
                        let _ = self.check()
                    }
                }
            }
            
            if item.isKind(of: ImageViewBehavior.classForCoder()) {
                let itemReal = item as! ImageViewBehavior
                itemReal.reactive.signal(forKeyPath: "imageView").observe({ (obj) in
                    itemReal.imageView.reactive.signal(forKeyPath: "image").observe({ (obj) in
                        let _ = self.check()
                    })
                })
            }
        }
    }
    
    
    func btnCheck() {
        for item in behaviors {
            if item.isKind(of: TextfieldBehavior.classForCoder()) {
                let itemReal = item as! TextfieldBehavior
                itemReal.reactive.signal(forKeyPath: "textField").observe { (obj) in
                    self.initSubBehaviorCount = self.initSubBehaviorCount + 1
                    if self.initSubBehaviorCount == self.behaviors.count {
                        let _ = self.check()
                    }
                }
            }
            
            if item.isKind(of: ImageViewBehavior.classForCoder()) {
                let itemReal = item as! ImageViewBehavior
                itemReal.reactive.signal(forKeyPath: "imageView").observe({ (obj) in
                   
                    self.initSubBehaviorCount = self.initSubBehaviorCount + 1
                    if self.initSubBehaviorCount == self.behaviors.count {
                        let _ = self.check()
                    }
                })
            }
        }
        
        
    }
    
    override func check() -> Bool {
        var checkState = true
        for item in behaviors {
            checkState = checkState && item.check()
            if checkState == false {
                break
            }
        }
        btn.isEnabled = checkState
        
        if checkState {
            btn.backgroundColor = normalColor
        } else {
            btn.backgroundColor = disableColor
        }
        
        return checkState
    }
    
}
