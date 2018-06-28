//
//  SwiftTest.swift
//  Swift_OC
//
//  Created by lingda on 2018/6/27.
//  Copyright © 2018年 lingda. All rights reserved.
//

import Foundation

class Man: NSObject {
    public static func say() {
        print("我是男人")
        People.say()
    }
    
    public static func hi() {
        print("我是个男人")
        People.hi()
    }
}
