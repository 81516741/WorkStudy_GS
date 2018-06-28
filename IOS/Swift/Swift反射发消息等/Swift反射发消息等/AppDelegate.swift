//
//  AppDelegate.swift
//  Swift反射发消息等
//
//  Created by lingda on 2018/6/26.
//  Copyright © 2018年 lingda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Awake.performOnce()
        return true
    }
}

protocol AwakeProtocol {
    static func awake ()
}

class Awake {
    fileprivate class func performOnce () {
        let count = Int(objc_getClassList(nil, 0))
        let classSpace = UnsafeMutablePointer<AnyClass?>.allocate(capacity: count)
        let autorealse = AutoreleasingUnsafeMutablePointer<AnyClass>(classSpace)
        objc_getClassList(autorealse, Int32(count))
        for i in 0..<count {
            (classSpace[i] as? AwakeProtocol.Type)?.awake()
        }
        classSpace.deallocate()
    }
}

