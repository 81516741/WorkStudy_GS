//
//  Behavior.swift
//  iMTC-Swift
//
//  Created by ld on 2018/1/2.
//  Copyright © 2018年 ld. All rights reserved.
//

import UIKit

class Behavior: UIControl {
    
    @IBOutlet weak var owner:NSObject?
    {
        didSet {
            releaseLifetimeFromObject(object: owner!)
            bindLifetimeToObject(object: owner!)
        }
        
    }
    
    private var key: Void?

    func bindLifetimeToObject(object o:NSObject)
    {
        objc_setAssociatedObject(o,&key,self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func releaseLifetimeFromObject(object o:NSObject) {
        objc_setAssociatedObject(o,&key,nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func check() -> Bool {
        return true
    }
}
