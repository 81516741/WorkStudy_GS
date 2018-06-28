//
//  ViewController.swift
//  Swift反射发消息等
//
//  Created by lingda on 2018/6/26.
//  Copyright © 2018年 lingda. All rights reserved.

import UIKit

private var lableKey: Void?
extension UILabel {
    @IBInspectable var italic:Bool {
        set {
            objc_setAssociatedObject(self, &lableKey, italic, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.transform = CGAffineTransform(a: 1, b: 0, c: CGFloat(tanf(Float(-15 * Double.pi / 180.0))), d: 1, tx: 0, ty: 0)
        }
        
        get {
            return objc_getAssociatedObject(self, &lableKey) as? Bool ?? false
        }
        
        
    }
}

@objcMembers
class Person : NSObject{
    var age:Int
    var name:String
    var address:String
    init(age:Int = 0,name:String = "",address:String = "") {
        self.age = age
        self.name = name
        self.address = address
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let p = Person(age: 10, name: "nihao", address: "beijing")
        fetchMirror(p)
        fetchProperty(p)
    }

    private func fetchMirror(_ obj: Any) {
        let mirror = Mirror(reflecting: obj)
        print(mirror.subjectType)
        print(mirror.children.count)
        for case let (key,value) in mirror.children {
            print("属性\(key!),值\(value)")
        }
    }
    
    func fetchProperty(_ obj: AnyObject) {
        var outCount:UInt32
        outCount = 0
        let peopers:UnsafeMutablePointer<objc_property_t>! =  class_copyPropertyList(obj.classForCoder, &outCount)
        let count:Int = Int(outCount);
        print(outCount)
        for i in 0...(count-1) {
            let aPro: objc_property_t = peopers[i]
            let proName:String! = String(utf8String: property_getName(aPro))
            guard let proAttr = property_getAttributes(aPro) else {
                return
            }
            let proAttrString : String! = String(utf8String: proAttr)
            print("属性名字\(proName),属性attr\(proAttrString)")
            
        }
    }
}

extension ViewController: AwakeProtocol {
    static  func awake() {
        guard let methodNew = class_getInstanceMethod(self, #selector(ld_viewWillAppear(_:))) else {
            return
        }
        guard let methodOld = class_getInstanceMethod(self, #selector(viewWillAppear(_:))) else {
            return
        }
        method_exchangeImplementations(methodNew, methodOld)
    }
    
    @objc fileprivate func ld_viewWillAppear(_ animated:Bool) {
        ld_viewWillAppear(animated)
        print("我已经被替换了，哈哈")
    }
}

